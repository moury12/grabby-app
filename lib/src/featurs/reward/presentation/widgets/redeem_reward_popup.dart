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
          spacing: 8,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.kPrimaryColor,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                ImagesConstant.kGiftIcon,
                height: 32,
                width: 32,
                colorFilter: const ColorFilter.mode(
                  Colors.white, // White icon
                  BlendMode.srcIn,
                ),
              ),
            ),

            // Title and Description
            Column(
              spacing: 4,
              children: [
                CustomText(
                  AppStaticStrings.redeemRewardTitle,
                  fontSize: ResponsiveTextSizes.getFontSizeExtraLarge(context),
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  AppStaticStrings.redeemRewardDesc,
                  textAlign: TextAlign.center,
                  fontSize: ResponsiveTextSizes.getFontSizeSmall(context),
                  color: AppColors.kSecondaryTextColor,
                ),
              ],
            ),

            space12H,

            // Points Summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                spacing: 4,
                children: [
                  _buildPointRow(
                    context,
                    AppStaticStrings.currentPoints,
                    "1340",
                    isBold: false,
                  ),
                  _buildPointRow(
                    context,
                    AppStaticStrings.pointsRequiredLabel,
                    "-1000",
                    isBold: false,
                    color: AppColors.kRedColor,
                  ),
                  const Divider(color: Colors.black12),
                  _buildPointRow(
                    context,
                    AppStaticStrings.remainingPoints,
                    "340",
                    isBold: true,
                    color: AppColors.kPrimaryColor,
                  ),
                ],
              ),
            ),

            // space12H,

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
                  borderColor: Colors.black12,
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
    BuildContext context,
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
          fontSize: ResponsiveTextSizes.getFontSizeSmall(context),
          fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          color: isBold ? AppColors.kTextColor : AppColors.kSecondaryTextColor,
        ),
        CustomText(
          value,
          fontSize: ResponsiveTextSizes.getFontSizeSmall(context),
          fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          color: color,
        ),
      ],
    );
  }
}
