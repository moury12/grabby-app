import '../../../../src_export.dart';

class LoyaltyRewardPage extends StatelessWidget {
  const LoyaltyRewardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStaticStrings.loyaltyReward)),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context).copyWith(top: 0),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Point Card (Header)
            Container(
              width: double.infinity,
              padding: AppPadding.getPadding12(context),
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: [
                          CustomText(
                            AppStaticStrings.gPoints,
                            fontSize: ResponsiveTextSizes.getFontSizeSemiSmall(
                              context,
                            ),
                            fontWeight: FontWeight.w600,
                          ),
                          CustomText(
                            "1350 Points",
                            fontSize: ResponsiveTextSizes.getFontSizeExtraLarge(
                              context,
                            ),
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: 4,
                        children: [
                          CustomText(
                            AppStaticStrings.walletBalance,
                            fontSize: ResponsiveTextSizes.getFontSizeSemiSmall(
                              context,
                            ),
                            fontWeight: FontWeight.w600,
                          ),
                          CustomText(
                            "133.85 AED",
                            fontSize: ResponsiveTextSizes.getFontSizeExtraLarge(
                              context,
                            ),
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                  space8H,
                  Column(
                    spacing: 8,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            AppStaticStrings.progressToNextReward,
                            fontSize: ResponsiveTextSizes.getFontSizeSmall(
                              context,
                            ),
                            color: AppColors.kSecondaryTextColor,
                          ),
                          CustomText(
                            "1340 / 1000 Points",
                            fontSize: ResponsiveTextSizes.getFontSizeSmall(
                              context,
                            ),
                            color: AppColors.kSecondaryTextColor,
                          ),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: const LinearProgressIndicator(
                          value: .8,
                          minHeight: 8,
                          backgroundColor: Colors.black12,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Available Rewards Section
            CustomText(
              AppStaticStrings.availableRewards,
              fontSize: ResponsiveTextSizes.getFontSizeDefault(context),
              fontWeight: FontWeight.bold,
            ),

            _buildRewardCard(
              context,
              title: AppStaticStrings.tenPercentDiscount,
              subTitle: "500 ${AppStaticStrings.pointsRequired}",
            ),

            _buildRewardCard(
              context,
              title: AppStaticStrings.fifteenPercentDiscount,
              subTitle: "1000 ${AppStaticStrings.pointsRequired}",
            ),

            _buildRewardCard(
              context,
              title: AppStaticStrings.fifteenAED,
              subTitle: "1500 ${AppStaticStrings.pointsRequired}",
            ),

            _buildRewardCard(
              context,
              title: AppStaticStrings.twentyAED,
              subTitle: "2000 ${AppStaticStrings.pointsRequired}",
            ),

            // Warning Banner
            Container(
              padding: AppPadding.getPadding12(context),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Row(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.help_outline,
                    color: Colors.amber.shade800,
                    size: 20,
                  ),
                  Expanded(
                    child: CustomText(
                      AppStaticStrings.validForSelectedShops,
                      fontSize: ResponsiveTextSizes.getFontSizeSmall(context),
                      color: const Color(0xFF856404),
                    ),
                  ),
                ],
              ),
            ),

            // How Reward Points Work Section
            Container(
              width: double.infinity,
              padding: AppPadding.getPadding12(context),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  CustomText(
                    AppStaticStrings.howRewardPointsWork,
                    fontSize: ResponsiveTextSizes.getFontSizeSemiSmall(context),
                    fontWeight: FontWeight.bold,
                  ),
                  _buildStepItem(
                    context,
                    number: "1",
                    title: AppStaticStrings.earnPoints,
                    description: AppStaticStrings.earnPointsDesc,
                  ),
                  _buildStepItem(
                    context,
                    number: "2",
                    title: AppStaticStrings.unlockRewards,
                    description: AppStaticStrings.unlockRewardsDesc,
                  ),
                  _buildStepItem(
                    context,
                    number: "3",
                    title: AppStaticStrings.redeemAndSave,
                    description: AppStaticStrings.redeemAndSaveDesc,
                  ),
                ],
              ),
            ),
            space12H,
          ],
        ),
      ),
    );
  }

  Widget _buildRewardCard(
    BuildContext context, {
    required String title,
    required String subTitle,
  }) {
    return Container(
      width: double.infinity,
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        spacing: 12,
        children: [
          Row(
            spacing: 12,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    CustomText(
                      title,
                      fontSize: ResponsiveTextSizes.getFontSizeSemiSmall(
                        context,
                      ),
                      fontWeight: FontWeight.bold,
                      color: AppColors.kPrimaryColor,
                    ),
                    CustomText(
                      subTitle,
                      fontSize: ResponsiveTextSizes.getFontSizeSmall(context),
                      color: AppColors.kSecondaryTextColor,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SvgPicture.asset(
                  ImagesConstant.kGiftIcon,
                  height: 24,
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
          CustomButton(
            text: AppStaticStrings.redeemNow,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const RedeemRewardPopup(),
              );
            },
            backgroundColor: AppColors.kPrimaryColor,
            borderRadius: 12,
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(
    BuildContext context, {
    required String number,
    required String title,
    required String description,
  }) {
    return Row(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 28,
          width: 28,
          decoration: BoxDecoration(
            color: AppColors.kPrimaryColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: CustomText(
              number,
              fontSize: ResponsiveTextSizes.getFontSizeSmall(context),
              fontWeight: FontWeight.bold,
              color: AppColors.kPrimaryColor,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              CustomText(
                title,
                fontSize: ResponsiveTextSizes.getFontSizeSmall(context),
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                description,
                fontSize: ResponsiveTextSizes.getFontSizeSmall(context),
                color: AppColors.kSecondaryTextColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
