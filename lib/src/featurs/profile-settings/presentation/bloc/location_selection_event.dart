part of 'location_selection_bloc.dart';

@immutable
abstract class LocationSelectionEvent {}

class MapCameraMoved extends LocationSelectionEvent {
  final LatLng position;
  MapCameraMoved({required this.position});
}

class MapCameraIdle extends LocationSelectionEvent {
  final LatLng position;
  MapCameraIdle({required this.position});
}

class FetchCurrentLocation extends LocationSelectionEvent {}

class ConfirmLocationSelected extends LocationSelectionEvent {}
