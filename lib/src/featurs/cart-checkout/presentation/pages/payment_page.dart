import '../../../../src_export.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedMethod = "Credit/Debit Card";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStaticStrings.payment)),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pickup Details
            _buildSection(
              title: AppStaticStrings.pickupDetails,
              child: const Column(
                spacing: 12,
                children: [
                  PickupDetailItem(
                    icon: ImagesConstant.kCarIcon,
                    title: AppStaticStrings.carPickup,
                    subtitle: "ABC 1234",
                    iconColor: Colors.white,
                    backgroundColor: AppColors.kPrimaryColor,
                  ),
                  PickupDetailItem(
                    icon: ImagesConstant.kClockIcon,
                    title: AppStaticStrings.readyIn1520mins,
                    subtitle: "Brew & Co - Main Street",
                  ),
                ],
              ),
            ),

            // Payment Method
            _buildSection(
              title: AppStaticStrings.paymentMethod,
              child: Column(
                spacing: 12,
                children: [
                  PaymentMethodCard(
                    icon: "card",
                    title: AppStaticStrings.creditDebitCard,
                    subtitle: "•••• 4242",
                    isSelected: _selectedMethod == "Credit/Debit Card",
                    onTap: () =>
                        setState(() => _selectedMethod = "Credit/Debit Card"),
                  ),
                  // PaymentMethodCard(
                  //   icon: "wallet",
                  //   title: AppStaticStrings.digitalWallet,
                  //   subtitle: "Apple Pay/ Goggle Pay",
                  //   isSelected: _selectedMethod == "Digital Wallet",
                  //   onTap: () =>
                  //       setState(() => _selectedMethod = "Digital Wallet"),
                  // ),
                ],
              ),
            ),

            // Available Credit
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        AppStaticStrings.availableCredit,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomText(
                        "5.00 AED",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const CustomText(
                      AppStaticStrings.applyCredit,
                      fontSize: 14,
                      color: Color(0xFFA59BF9),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Summary
            Column(
              spacing: 8,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      AppStaticStrings.subtotal,
                      fontSize: 14,
                      color: AppColors.kSecondaryTextColor,
                    ),
                    CustomText(
                      "16.60 AED",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      AppStaticStrings.orderTotal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      "16.60 AED",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFA59BF9),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: AppPadding.getPadding12(context).copyWith(bottom: 24),
        child: CustomButton(
          text: "${AppStaticStrings.payNow} 16.60 AED",
          onPressed: () {
            context.pushNamed(RoutesPath.paymentSuccessPath);
          },
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        CustomText(title, fontSize: 16, fontWeight: FontWeight.bold),
        child,
      ],
    );
  }
}
