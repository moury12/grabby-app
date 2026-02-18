import '../../../../src_export.dart';

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStaticStrings.orderTracking)),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      CustomText(
                        AppStaticStrings.orderNumber,
                        fontSize: 12,
                        color: AppColors.kSecondaryTextColor,
                      ),

                      CustomText(
                        "Brew & Co - Main Street",
                        fontSize: 12,
                        color: AppColors.kSecondaryTextColor,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 4,
                    children: [
                      CustomText(
                        "#GC12345",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        AppStaticStrings.readyForPickup,
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Stepper
            const TrackingStepperWidget(currentStep: 2),

            // Map Placeholder
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  Icon(Icons.location_on, color: Color(0xFFA59BF9), size: 40),
                  const CustomText(
                    "Brew & Co - Main Street 0.3 Km away",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    AppStaticStrings.arrivalNotificationDesc,
                    fontSize: 12,
                    color: AppColors.kSecondaryTextColor,
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: CustomButton(
                    text: AppStaticStrings.navigateToCafe,
                    iconPath: ImagesConstant.kNavigationIcon,
                    onPressed: () {
                      context.push(RoutesPath.orderTrackingMapViewPath);
                    },
                  ),
                ),
                Expanded(
                  child: CustomButton(
                    text: AppStaticStrings.callShop,
                    iconPath: ImagesConstant.kCallIcon,
                    backgroundColor: AppColors.kSecondaryColor,
                    onPressed: () {
                      // context.push(RoutesPath.locationPath);
                    },
                  ),
                ),
              ],
            ),

            // Order Items
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                const CustomText(
                  AppStaticStrings.orderItems,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                const Column(
                  children: [
                    TrackingOrderItem(
                      quantity: "2x",
                      title: "Caffe Latte",
                      price: "9.00 AED",
                    ),
                    TrackingOrderItem(
                      quantity: "1x",
                      title: "Croissant",
                      price: "3.20 AED",
                    ),
                    TrackingOrderItem(
                      quantity: "1x",
                      title: "Club Sandwich",
                      price: "8.90 AED",
                    ),
                  ],
                ),
                const Divider(height: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      AppStaticStrings.orderTotal,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      "21.10 AED",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
            space12H,
          ],
        ),
      ),
    );
  }
}
