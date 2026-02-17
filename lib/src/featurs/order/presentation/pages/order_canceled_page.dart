import '../../../../src_export.dart';

class OrderCanceledPage extends StatelessWidget {
  const OrderCanceledPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const CustomText(
          "Order Canceled",
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: AppPadding.getPadding12(context),
        child: Column(
          spacing: 24,
          children: [
            // Order Number Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  CustomText(
                    "Order Number",
                    fontSize: 12,
                    color: AppColors.kSecondaryTextColor,
                  ),
                  CustomText(
                    "Brew & Co - Main Street",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),

            // Cancellation Status Card
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                    const CustomText(
                      "Cancelled",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    const CustomText(
                      "The shop didn't confirm your order within the required time. Your order has been cancelled.",
                      textAlign: TextAlign.center,
                      fontSize: 14,
                      color: AppColors.kSecondaryTextColor,
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F2FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const CustomText(
                        "Any paid amount will be refunded as in-app credit.",
                        textAlign: TextAlign.center,
                        fontSize: 12,
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Back to Home Button
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "Back to Home",
                onPressed: () {
                  context.go(RoutesPath.navigationPath);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
