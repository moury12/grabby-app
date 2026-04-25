
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../src_export.dart';

class OrderTrackingMapViewPage extends StatefulWidget {
  final String orderId;
  const OrderTrackingMapViewPage({super.key, required this.orderId});

  @override
  State<OrderTrackingMapViewPage> createState() => _OrderTrackingMapViewPageState();
}

class _OrderTrackingMapViewPageState extends State<OrderTrackingMapViewPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(FetchOrderDetailsEvent(widget.orderId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStaticStrings.orderTracking)),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state.status == OrderStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == OrderStatus.failure) {
            return Center(child: CustomText(state.errorMessage ?? "Error loading order"));
          }
          final order = state.selectedOrder;
          if (order == null) {
            return const Center(child: CustomText("Order details not found"));
          }

          final branch = order.branchId is BranchInfo ? (order.branchId as BranchInfo) : null;
          final shopName = branch?.branchName ?? "no data";
          final orderId = order.orderId ?? order.id ?? "";
          final lat = branch?.lat ?? 25.2048;
          final lng = branch?.lng ?? 55.2708;

          return RefreshIndicator(
            onRefresh: () async {
              context.read<OrderBloc>().add(FetchOrderDetailsEvent(widget.orderId));
            },
            child: SingleChildScrollView(
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
                        initialCameraPosition: CameraPosition(
                          target: LatLng(lat, lng),
                          zoom: 14,
                        ),
                        zoomControlsEnabled: false,
                        myLocationButtonEnabled: false,
                        markers: {
                          Marker(
                            markerId: const MarkerId('shop'),
                            position: LatLng(lat, lng),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 6,
                      children: [
                        const CustomText(
                          AppStaticStrings.orderNumber,
                          fontSize: 12,
                          color: AppColors.kSecondaryTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                        CustomText(
                          "#$orderId",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          shopName,
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

                  // Call Button
                  if (branch?.phoneNumber != null)
                    CustomButton(
                      text: "Call Shop",
                      onPressed: () async {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: branch!.phoneNumber,
                        );
                        await launchUrl(launchUri);
                      },
                      backgroundColor: AppColors.kGreenColor,
                      borderRadius: 16,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
