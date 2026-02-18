import '../../../../src_export.dart';

class RedeemRewardPopup extends StatelessWidget {
  const RedeemRewardPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                ImagesConstant.kGiftIcon,
                height: 32,
                width: 32,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),

            // Title and Description
            Column(
              spacing: 8,
              children: [
                const CustomText(
                  AppStaticStrings.redeemRewardTitle,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                const CustomText(
                  AppStaticStrings.redeemRewardDesc,
                  textAlign: TextAlign.center,
                  fontSize: 14,
                  color: AppColors.kSecondaryTextColor,
                ),
              ],
            ),

            const Divider(),

            // Points Summary
            Column(
              spacing: 8,
              children: [
                _buildPointRow(
                  AppStaticStrings.currentPoints,
                  "1340",
                  isBold: false,
                ),
                _buildPointRow(
                  AppStaticStrings.pointsRequiredLabel,
                  "-1000",
                  isBold: false,
                  color: Colors.red,
                ),
                const Divider(),
                _buildPointRow(
                  AppStaticStrings.remainingPoints,
                  "340",
                  isBold: true,
                  color: AppColors.kPrimaryColor,
                ),
              ],
            ),

            space12H,

            // Buttons
            Column(
              spacing: 12,
              children: [
                CustomButton(
                  text: AppStaticStrings.confirmRedemption,
                  onPressed: () {
                    context.pop();
                    // TODO: Logic for confirmation
                  },
                  backgroundColor: AppColors.kPrimaryColor,
                  borderRadius: 12,
                ),
                CustomButton(
                  text: AppStaticStrings.cancel,
                  onPressed: () => context.pop(),
                  backgroundColor: Colors.white,
                  textColor: AppColors.kTextColor,
                  isOutlined: true,
                  borderRadius: 12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPointRow(
    String label,
    String value, {
    bool isBold = false,
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          label,
          fontSize: 14,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          color: isBold ? AppColors.kTextColor : AppColors.kSecondaryTextColor,
        ),
        CustomText(
          value,
          fontSize: 14,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          color: color,
        ),
      ],
    );
  }
}
