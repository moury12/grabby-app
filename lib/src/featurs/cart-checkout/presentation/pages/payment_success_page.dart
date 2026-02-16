import '../../../../src_export.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2FF),
      body: Padding(
        padding: AppPadding.getPadding12(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            const Spacer(),
            // Success Icon
            Container(
              padding: AppPadding.getPadding12(context),
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                ImagesConstant.kSuccesfullIcon,
                height: 80,
              ),
            ),
            const Column(
              spacing: 8,
              children: [
                CustomText(
                  AppStaticStrings.paymentSuccessful,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  "Your order has been placed successfully",
                  fontSize: 16,
                  color: AppColors.kSecondaryTextColor,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            // Order Summary Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                spacing: 12,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        AppStaticStrings.orderNumber,
                        color: AppColors.kSecondaryTextColor,
                      ),
                      CustomText("#GC12345", fontWeight: FontWeight.bold),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        AppStaticStrings.totalPaid,
                        color: AppColors.kSecondaryTextColor,
                      ),
                      CustomText(
                        "11.60 AED",
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA59BF9),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Action Buttons
            Column(
              spacing: 12,
              children: [
                CustomButton(
                  text: AppStaticStrings.trackOrder,
                  onPressed: () {
                    context.pushNamed(RoutesPath.orderTrackingPath);
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      context.go(RoutesPath.navigationPath);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Color(0xFFA59BF9)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const CustomText(
                      AppStaticStrings.backToHome,
                      color: Color(0xFFA59BF9),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
