import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'location_selection_event.dart';
part 'location_selection_state.dart';

class LocationSelectionBloc
    extends Bloc<LocationSelectionEvent, LocationSelectionState> {
  Timer? _debounce;

  LocationSelectionBloc() : super(LocationSelectionInitial()) {
    on<MapCameraMoved>(_onMapCameraMoved);
    on<MapCameraIdle>(_onMapCameraIdle);
    on<FetchCurrentLocation>(_onFetchCurrentLocation);
    on<ConfirmLocationSelected>(_onConfirmLocationSelected);
    on<_ReverseGeocodeEvent>(_onReverseGeocode);
  }

  void _onMapCameraMoved(
    MapCameraMoved event,
    Emitter<LocationSelectionState> emit,
  ) {
    // Optional: emit temporary state if needed
  }

  Future<void> _onMapCameraIdle(
    MapCameraIdle event,
    Emitter<LocationSelectionState> emit,
  ) async {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      add(_ReverseGeocodeEvent(event.position));
    });
  }

  Future<void> _onReverseGeocode(
    _ReverseGeocodeEvent event,
    Emitter<LocationSelectionState> emit,
  ) async {
    emit(
      LocationSelectionUpdated(
        position: event.position,
        address: "Fetching address...",
        isReverseGeocoding: true,
      ),
    );

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        event.position.latitude,
        event.position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        List<String> addressParts = [
          if (place.street != null && place.street!.isNotEmpty) place.street!,
          if (place.subLocality != null && place.subLocality!.isNotEmpty)
            place.subLocality!,
          if (place.locality != null && place.locality!.isNotEmpty)
            place.locality!,
          if (place.postalCode != null && place.postalCode!.isNotEmpty)
            place.postalCode!,
          if (place.country != null && place.country!.isNotEmpty)
            place.country!,
        ];

        String address = addressParts.join(", ");

        emit(
          LocationSelectionUpdated(
            position: event.position,
            address: address,
            isReverseGeocoding: false,
          ),
        );
      } else {
        emit(
          LocationSelectionUpdated(
            position: event.position,
            address: "Address not found",
            isReverseGeocoding: false,
          ),
        );
      }
    } catch (e) {
      emit(
        LocationSelectionUpdated(
          position: event.position,
          address: "Error fetching address",
          isReverseGeocoding: false,
        ),
      );
    }
  }

  Future<void> _onFetchCurrentLocation(
    FetchCurrentLocation event,
    Emitter<LocationSelectionState> emit,
  ) async {
    emit(LocationSelectionLoading());
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(
          LocationSelectionError(message: 'Location services are disabled.'),
        );
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(
            LocationSelectionError(message: 'Location permissions are denied'),
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(
          LocationSelectionError(
            message: 'Location permissions are permanently denied.',
          ),
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      LatLng latLng = LatLng(position.latitude, position.longitude);

      add(MapCameraIdle(position: latLng));
    } catch (e) {
      emit(LocationSelectionError(message: e.toString()));
    }
  }

  void _onConfirmLocationSelected(
    ConfirmLocationSelected event,
    Emitter<LocationSelectionState> emit,
  ) {
    // This could just be a signal to the UI to pop with the result
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}

// Internal event for handling the async geocoding after debounce
class _ReverseGeocodeEvent extends LocationSelectionEvent {
  final LatLng position;
  _ReverseGeocodeEvent(this.position);
}
