import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../src_export.dart';

class OrderTrackingMapViewPage extends StatelessWidget {
  const OrderTrackingMapViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStaticStrings.orderTracking)),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          spacing: 12,
          children: [
            // Map Section
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 250,
                width: double.infinity,
                child: GoogleMap(
                  style: '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#181818"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1b1b1b"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#2c2c2c"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8a8a8a"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#373737"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3c3c3c"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#4e4e4e"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#000000"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3d3d3d"
      }
    ]
  }
]''',
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(25.2048, 55.2708),
                    zoom: 14,
                  ),
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  markers: {
                    const Marker(
                      markerId: MarkerId('shop'),
                      position: LatLng(25.2048, 55.2708),
                    ),
                  },
                ),
              ),
            ),

            // Arrived Icon Section
            Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  ImagesConstant.kLocationIcon,
                  height: 48,
                  width: 48,
                  colorFilter: const ColorFilter.mode(
                    AppColors.kPrimaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),

            // Text Section
            const CustomText(
              AppStaticStrings.iveArrived,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),

            CustomText(
              AppStaticStrings.iveArrivedDesc,
              textAlign: TextAlign.center,
              fontSize: 14,
              color: AppColors.kSecondaryTextColor,
            ),

            // Order Card Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6,
                children: [
                  CustomText(
                    AppStaticStrings.orderNumber,
                    fontSize: 12,
                    color: AppColors.kSecondaryTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    "#GC12345",
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    "Brew & Co - Main Street",
                    fontSize: 14,
                    color: AppColors.kSecondaryTextColor,
                  ),
                ],
              ),
            ),

            // Bottom Button
            CustomButton(
              text: AppStaticStrings.notifyShop,
              onPressed: () {
                // Logic for notify shop
              },
              backgroundColor: AppColors.kPrimaryColor,
              borderRadius: 16,
            ),
          ],
        ),
      ),
    );
  }
}
