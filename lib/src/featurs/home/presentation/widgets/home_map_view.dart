import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../src_export.dart';

class HomeMapView extends StatefulWidget {
  const HomeMapView({super.key});

  @override
  State<HomeMapView> createState() => _HomeMapViewState();
}

class _HomeMapViewState extends State<HomeMapView> {
  LatLng _initialPosition = const LatLng(23.8103, 90.4125); // Dhaka default
  bool _isLocationLoaded = false;
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final position = await sl<LocationService>().getCurrentPosition();
    if (position != null && mounted) {
      setState(() {
        _initialPosition = LatLng(position.latitude, position.longitude);
        _isLocationLoaded = true;
      });
      _fitToMarkers();
    }
  }

  void _fitToMarkers() {
    if (_mapController == null) return;

    List<LatLng> points = [];
    if (_isLocationLoaded) {
      points.add(_initialPosition);
    }
    
    for (var marker in _markers) {
      points.add(marker.position);
    }

    if (points.isEmpty) return;

    LatLngBounds bounds;
    if (points.length == 1) {
      bounds = LatLngBounds(southwest: points.first, northeast: points.first);
    } else {
      double minLat = points.first.latitude;
      double maxLat = points.first.latitude;
      double minLng = points.first.longitude;
      double maxLng = points.first.longitude;

      for (var point in points) {
        if (point.latitude < minLat) minLat = point.latitude;
        if (point.latitude > maxLat) maxLat = point.latitude;
        if (point.longitude < minLng) minLng = point.longitude;
        if (point.longitude > maxLng) maxLng = point.longitude;
      }
      bounds = LatLngBounds(
        southwest: LatLng(minLat, minLng),
        northeast: LatLng(maxLat, maxLng),
      );
    }

    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 70), // 70 is padding
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerBranchBloc, CustomerBranchState>(
      listener: (context, state) {
        if (state is CustomerBranchesLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) => _fitToMarkers());
        }
      },
      child: BlocBuilder<CustomerBranchBloc, CustomerBranchState>(
        builder: (context, state) {
          LatLng targetPosition = _initialPosition;

          if (state is CustomerBranchesLoaded) {
            _markers = state.branches.map((branch) {
              return Marker(
                markerId: MarkerId(branch.id),
                position: LatLng(branch.lat, branch.lng),
                infoWindow: InfoWindow(
                  title: branch.branchName,
                  snippet: branch.statusText,
                  onTap: () {
                    context.pushNamed(
                      RoutesPath.restruantDetailsPath,
                      extra: branch.id,
                    );
                  },
                ),
              );
            }).toSet();

            if (!_isLocationLoaded && state.branches.isNotEmpty) {
              final first = state.branches.first;
              targetPosition = LatLng(first.lat, first.lng);
            }
          }

          return SliverFillRemaining(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: targetPosition,
                zoom: 12,
              ),
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              onMapCreated: (controller) {
                _mapController = controller;
                if (_markers.isNotEmpty || _isLocationLoaded) {
                  _fitToMarkers();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
