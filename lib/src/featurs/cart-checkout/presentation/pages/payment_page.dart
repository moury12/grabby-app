import 'dart:async';
import 'dart:convert';
import '../../../../src_export.dart';

class PaymentPage extends StatefulWidget {
  final OrderModel order;
  const PaymentPage({super.key, required this.order});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isProcessing = false;

  Future<void> _startPayment() async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulate processing

      if (!mounted) return;
      setState(() => _isProcessing = false);

      context.pushReplacementNamed(
        RoutesPath.paymentSuccessPath,
        extra: widget.order,
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isProcessing = false);
      _showError("Payment failed: ${e.toString()}");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

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
              child: PickupDetailItem(
                icon: ImagesConstant.kCarIcon,
                title: widget.order.pickupType == "carPickup"
                    ? AppStaticStrings.carPickup
                    : AppStaticStrings.counterPickup,
                subtitle: widget.order.carPlates ?? "",
                iconColor: Colors.white,
                backgroundColor: AppColors.kPrimaryColor,
              ),
            ),

            // Payment Method
            _buildSection(
              title: AppStaticStrings.paymentMethod,
              child: _buildPaymentCard(),
            ),

            // Order Summary
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
          text: _isProcessing ? "Processing..." : "Confirm Payment",
          onPressed: () {
            _isProcessing ? null : _startPayment();
          },
        ),
      ),
    );
  }

  Widget _buildPaymentCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.kPrimaryColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.kPrimaryColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(Icons.payment, color: Colors.white),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'Payment',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 2),
                CustomText(
                  'Credit / Debit Card · Apple Pay · Samsung Pay',
                  fontSize: 11,
                  color: AppColors.kSecondaryTextColor,
                ),
              ],
            ),
          ),
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.kPrimaryColor,
            size: 22,
          ),
        ],
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
