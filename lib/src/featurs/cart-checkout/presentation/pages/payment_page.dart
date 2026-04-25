import '../../../../src_export.dart';

class PaymentPage extends StatefulWidget {
  final OrderModel order;
  const PaymentPage({super.key, required this.order});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedMethod = "Credit Card";

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
              child: Column(
                spacing: 12,
                children: [
                  PickupDetailItem(
                    icon: ImagesConstant.kCarIcon,
                    title: widget.order.pickupType == "carPickup"
                        ? AppStaticStrings.carPickup
                        : AppStaticStrings.counterPickup,
                    subtitle: widget.order.carPlates ?? "",
                    iconColor: Colors.white,
                    backgroundColor: AppColors.kPrimaryColor,
                  ),
                  // PickupDetailItem(
                  //   icon: ImagesConstant.kClockIcon,
                  //   title: AppStaticStrings.readyIn1520mins,
                  //   subtitle: widget.order.branchId is BranchInfo
                  //       ? (widget.order.branchId as BranchInfo).branchName
                  //       : "", // This could also be dynamic if branch info is available
                  // ),
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
                    title:
                        widget.order.paymentMethod ??
                        AppStaticStrings.creditDebitCard,
                    subtitle: widget.order.transactionId != null
                        ? "ID: ${widget.order.transactionId}"
                        : "•••• 4242",
                    isSelected: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),

            // Available Credit
            // Container(
            //   padding: const EdgeInsets.all(12),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     spacing: 8,
            //     children: [
            //       const Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           CustomText(
            //             AppStaticStrings.availableCredit,
            //             fontSize: 14,
            //             fontWeight: FontWeight.w500,
            //           ),
            //           CustomText(
            //             "5.00 AED",
            //             fontSize: 14,
            //             fontWeight: FontWeight.bold,
            //             color: Colors.green,
            //           ),
            //         ],
            //       ),
            //       GestureDetector(
            //         onTap: () {},
            //         child: const CustomText(
            //           AppStaticStrings.applyCredit,
            //           fontSize: 14,
            //           color: Color(0xFFA59BF9),
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // // Summary
            Column(
              spacing: 8,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      AppStaticStrings.orderNumber,
                      fontSize: 14,
                      color: AppColors.kSecondaryTextColor,
                    ),
                    CustomText(
                      widget.order.orderId ?? "",
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
                      "${widget.order.totalAmount.toStringAsFixed(2)} AED",
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
          text: AppStaticStrings.paymentSuccess,
          onPressed: () {
            context.pushReplacementNamed(
              RoutesPath.paymentSuccessPath,
              extra: widget.order,
            );
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
