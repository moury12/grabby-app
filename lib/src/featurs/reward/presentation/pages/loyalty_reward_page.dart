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
            // Total Point Card
            Container(
              width: double.infinity,
              padding: AppPadding.getPadding12(context),
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  const CustomText(
                    AppStaticStrings.totalPoint,
                    fontSize: 14,
                    color: AppColors.kSecondaryTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                  const CustomText(
                    "1350 Points",
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        AppStaticStrings.progressToNextReward,
                        fontSize: 12,
                        color: AppColors.kSecondaryTextColor,
                      ),
                      const CustomText(
                        "1340 / 1000 Points",
                        fontSize: 12,
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
            ),

            // Available Rewards Section
            const CustomText(
              AppStaticStrings.availableRewards,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),

            _buildRewardCard(
              context,
              title: AppStaticStrings.tenPercentDiscount,
              subTitle: "1,000 ${AppStaticStrings.pointsRequired}",
            ),

            _buildRewardCard(
              context,
              title: AppStaticStrings.fifteenPercentDiscount,
              subTitle: "2,500 ${AppStaticStrings.pointsRequired}",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.amber.shade800,
                    size: 20,
                  ),
                  const Expanded(
                    child: CustomText(
                      AppStaticStrings.validForSelectedShops,
                      fontSize: 12,
                      color: Color(0xFF856404),
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
                  const CustomText(
                    AppStaticStrings.howRewardPointsWork,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  _buildStepItem(
                    number: "1",
                    title: AppStaticStrings.earnPoints,
                    description: AppStaticStrings.earnPointsDesc,
                  ),
                  _buildStepItem(
                    number: "2",
                    title: AppStaticStrings.unlockRewards,
                    description: AppStaticStrings.unlockRewardsDesc,
                  ),
                  _buildStepItem(
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kPrimaryColor,
                    ),
                    CustomText(
                      subTitle,
                      fontSize: 12,
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

  Widget _buildStepItem({
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
              fontSize: 12,
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
              CustomText(title, fontSize: 14, fontWeight: FontWeight.bold),
              CustomText(
                description,
                fontSize: 12,
                color: AppColors.kSecondaryTextColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
