import '../../../../src_export.dart';

class MarketingCampaignsPage extends StatelessWidget {
  const MarketingCampaignsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> campaignTiers = [
      {
        'tier': AppStaticStrings.tier1,
        'duration': AppStaticStrings.fiveDaysCampaign,
        'price': '200',
        'perDay': '40',
        'icon': ImagesConstant.kMarketingCampaigns1,
        'color': const Color(0xFF1E88E5),
      },
      {
        'tier': AppStaticStrings.tier2,
        'duration': AppStaticStrings.tenDaysCampaign,
        'price': '400',
        'perDay': '40',
        'icon': ImagesConstant.kMarketingCampaigns2,
        'color': const Color(0xFF9575CD),
      },
      {
        'tier': AppStaticStrings.tier3,
        'duration': AppStaticStrings.twentyDaysCampaign,
        'price': '550',
        'perDay': '27',
        'icon': ImagesConstant.kMarketingCampaigns3,
        'color': const Color(0xFFFB8C00),
      },
      {
        'tier': AppStaticStrings.tier4,
        'duration': AppStaticStrings.thirtyDaysCampaign,
        'price': '660',
        'perDay': '22',
        'icon': ImagesConstant.kMarketingCampaigns4,
        'color': const Color(0xFFFBC02D),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          AppStaticStrings.marketingCampaigns,
          variant: TextVariant.headlineSmall,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context).copyWith(top: 0),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // "All Campaigns Include" section
            Container(
              padding: AppPadding.getPadding10(context),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.trending_up,
                        size: 20,
                        color: AppColors.kPrimaryColor,
                      ),
                      space8W,
                      const CustomText(
                        AppStaticStrings.allCampaignsInclude,
                        variant: TextVariant.labelLarge,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kPrimaryColor,
                      ),
                    ],
                  ),
                  const CheckmarkListItem(
                    icon: ImagesConstant.kRewardIcon,
                    title: AppStaticStrings.topListPlacement,
                    subtitle: AppStaticStrings.topListPlacementDesc,
                  ),
                  const CheckmarkListItem(
                    icon: ImagesConstant.kNotificationIcon,
                    title: AppStaticStrings.pushNotifications,
                    subtitle: AppStaticStrings.pushNotificationsDesc,
                  ),
                  const CheckmarkListItem(
                    // icon: ImagesConstant.kTopListPlacement,
                    title: AppStaticStrings.increasedVisibility,
                    subtitle: AppStaticStrings.increasedVisibilityDesc,
                  ),
                ],
              ),
            ),

            const CustomText(
              AppStaticStrings.chooseYourCampaignTier,
              variant: TextVariant.titleMedium,
              fontWeight: FontWeight.bold,
            ),

            // Campaign Tiers List
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: campaignTiers.length,
              separatorBuilder: (context, index) => space12H,
              itemBuilder: (context, index) {
                final tier = campaignTiers[index];
                return TierCardWidget(tier: tier);
              },
            ),

            // FAQ Section
            const CustomText(
              AppStaticStrings.frequentlyAskedQuestions,
              variant: TextVariant.titleMedium,
              fontWeight: FontWeight.bold,
            ),
            _buildFAQ(
              AppStaticStrings.howDoCampaignsWork,
              AppStaticStrings.campaignsWorkDesc,
            ),
            _buildFAQ(
              AppStaticStrings.canICancelCampaign,
              AppStaticStrings.cancelCampaignDesc,
            ),
            _buildFAQ(
              AppStaticStrings.howManyNotifications,
              AppStaticStrings.notificationsDesc,
            ),
            space24H,
          ],
        ),
      ),
    );
  }

  Widget _buildFAQ(String question, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          question,
          variant: TextVariant.labelLarge,
          fontWeight: FontWeight.bold,
        ),
        space4H,
        CustomText(
          answer,
          variant: TextVariant.labelSmall,
          color: AppColors.kSecondaryTextColor,
        ),
        space12H,
      ],
    );
  }
}
