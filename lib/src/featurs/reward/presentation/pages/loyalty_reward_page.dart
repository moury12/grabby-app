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
              padding: AppPadding.getPadding8(context),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.kPrimaryColor, AppColors.kSecondaryColor],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.emoji_events_outlined,
                    color: Colors.white,
                    size: 28,
                  ),

                  CustomText(
                    AppStaticStrings.totalPoints,
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                  const CustomText(
                    "94",
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  Divider(color: Colors.white24, height: 12),
                  CustomText(
                    AppStaticStrings.earnedCredit,
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                  const CustomText(
                    "AED 0.94",
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),

            // Progress Card
            Container(
              width: double.infinity,
              padding: AppPadding.getPadding12(context),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        AppStaticStrings.progressToNextReward,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.kTextColor,
                      ),
                      const CustomText(
                        "94/500",
                        fontSize: 12,
                        color: Color(0xFFA59BF9),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: const LinearProgressIndicator(
                      value: 94 / 500,
                      minHeight: 6,
                      backgroundColor: Color(0xFFE5E7EB),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFFA59BF9),
                      ),
                    ),
                  ),
                  const CustomText(
                    "406 more points to unlock 5 AED Grabby Credit",
                    fontSize: 11,
                    color: AppColors.kTextColor,
                  ),
                ],
              ),
            ),

            // Available Rewards Section
            CustomText(
              AppStaticStrings.availableRewards,
              variant: TextVariant.titleMedium,
            ),

            _buildRewardCard(
              context,
              title: "5 ${AppStaticStrings.earnedCredit}",
              subTitle: "500 ${AppStaticStrings.pointsRequired}",
            ),

            _buildRewardCard(
              context,
              title: "10 ${AppStaticStrings.earnedCredit}",
              subTitle: "1000 ${AppStaticStrings.pointsRequired}",
            ),

            _buildRewardCard(
              context,
              title: "15 ${AppStaticStrings.earnedCredit}",
              subTitle: "1500 ${AppStaticStrings.pointsRequired}",
            ),

            _buildRewardCard(
              context,
              title: "20 ${AppStaticStrings.earnedCredit}",
              subTitle: "2000 ${AppStaticStrings.pointsRequired}",
            ),

            // Warning Banner
            Container(
              padding: AppPadding.getPadding12(context),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEB),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFEF3C7)),
              ),
              child: Row(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    color: Color(0xFFF59E0B),
                    size: 20,
                  ),
                  Expanded(
                    child: CustomText(
                      AppStaticStrings.validForSelectedShops,
                      fontSize: 12,
                      color: const Color(0xFF92400E),
                    ),
                  ),
                ],
              ),
            ),

            // How Reward Points Work Section
            Container(
              width: double.infinity,
              padding: AppPadding.getPadding16(context),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  CustomText(
                    AppStaticStrings.howRewardPointsWork,
                    fontSize: 16,
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
      // padding: AppPadding.getPadding12(context),
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
      child: ButtonTapWidget(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => RedeemRewardPopup(),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 16,
            children: [
              Container(
                height: 48,
                width: 48,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F2FF),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  ImagesConstant.kGiftIcon,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFA59BF9),
                    BlendMode.srcIn,
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
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFA59BF9),
                    ),
                    CustomText(
                      subTitle,
                      fontSize: ResponsiveTextSizes.getFontSizeSmall(context),
                      color: AppColors.kSecondaryTextColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
