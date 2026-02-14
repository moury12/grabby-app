import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../src_export.dart';

class HomeMapView extends StatelessWidget {
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(3.1390, 101.6869), // Kuala Lumpur
          zoom: 14,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        mapType: MapType.normal,
      ),
    );
  }
}
