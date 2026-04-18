import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../src_export.dart';

class HomeMapView extends StatelessWidget {
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerBranchBloc, CustomerBranchState>(
      builder: (context, state) {
        Set<Marker> markers = {};
        LatLng initialPosition = const LatLng(23.8103, 90.4125); // Dhaka default

        if (state is CustomerBranchesLoaded) {
          print('Map View: Found ${state.branches.length} branches');
          markers = state.branches.map((branch) {
            print('Marker for ${branch.branchName}: ${branch.lat}, ${branch.lng}');
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

          if (state.branches.isNotEmpty) {
            final first = state.branches.first;
            initialPosition = LatLng(first.lat, first.lng);
            print('Map Camera Initial Position: ${initialPosition.latitude}, ${initialPosition.longitude}');
          }
        }

        return SliverFillRemaining(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: initialPosition,
              zoom: 12,
            ),
            markers: markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            onMapCreated: (controller) {
              // Optionally set map style or other settings here
            },
          ),
        );
      },
    );
  }
}
