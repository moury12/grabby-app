import '../../../../src_export.dart';

class BusinessProfilePage extends StatelessWidget {
  const BusinessProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          AppStaticStrings.businessProfile,
          variant: TextVariant.headlineSmall,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12H(context),
        child: Column(
          spacing: 6,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBusinessHeader(context),
            space2H,
            _buildStatsRow(context),
            space2H,
            ProfileMenuItem(
              title: AppStaticStrings.branchManagement,
              icon: Icons.store_outlined,
              onTap: () => context.pushNamed(RoutesPath.branchManagementName),
            ),
            Divider(color: Colors.white, height: 1),
            ProfileMenuItem(
              title: AppStaticStrings.branchTimings,
              icon: Icons.location_on_outlined,
              onTap: () => context.pushNamed(RoutesPath.branchTimingsName),
            ),
            Divider(color: Colors.white, height: 1),
            ProfileMenuItem(
              title: AppStaticStrings.marketingCampaigns,
              icon: Icons.campaign_outlined,
              onTap: () => context.pushNamed(RoutesPath.marketingCampaignsName),
            ),
            Divider(color: Colors.white, height: 1),
            ProfileMenuItem(
              title: AppStaticStrings.settings,
              icon: Icons.settings_outlined,
              onTap: () => context.pushNamed(RoutesPath.accountSettingsPath),
            ),
            Divider(color: Colors.white, height: 1),
            ProfileMenuItem(
              title: AppStaticStrings.notifications,
              icon: Icons.notifications_none_outlined,
              onTap: () => context.pushNamed(RoutesPath.notificationPath),
            ),
            // Divider(color: Colors.white, height: 1),
            // ProfileMenuItem(
            //   title: AppStaticStrings.rewardSettings,
            //   icon: Icons.card_giftcard_outlined,
            //   onTap: () => context.pushNamed(RoutesPath.rewardSettingsName),
            // ),
            Divider(color: Colors.white, height: 1),
            ProfileMenuItem(
              title: AppStaticStrings.helpCenter,
              icon: Icons.help_outline,
              onTap: () {},
            ),
            Divider(color: Colors.white, height: 1),
            ProfileMenuItem(
              title: AppStaticStrings.termsAndConditions,
              icon: Icons.description_outlined,
              onTap: () {},
            ),
            Divider(color: Colors.white, height: 1),
            CustomButton(
              text: AppStaticStrings.logOut,
              onPressed: () {
                context.goNamed(RoutesPath.loginPath);
              },
              icon: Icons.logout,
              iconColor: AppColors.kRedColor,
              textColor: AppColors.kTextColor,
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessHeader(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffA59BF9), Color(0xff7B6FD8)],
        ),
        borderRadius: BorderRadius.circular(appRadius),
      ),
      child: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 6,
            children: [
              CustomNetworkImage(
                imageUrl: "",
                width: 60,
                height: 60,
                radius: 12,
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "Brew & Co",
                      variant: TextVariant.titleLarge,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      "3 branches • 2 active",
                      variant: TextVariant.labelSmall,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ],
                ),
              ),
              FloatingActionButton.small(
                onPressed: () {
                  context.pushNamed(RoutesPath.personalInfoPath);
                },
                child: Icon(Icons.edit_outlined),
              ),
            ],
          ),

          CustomText(
            "sarah.mitchell@email.com",
            variant: TextVariant.labelMedium,
            color: Colors.white,
          ),
          CustomText(
            "+1 (555) 123-4567",
            variant: TextVariant.labelMedium,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return const Row(
      spacing: 6,
      children: [
        Expanded(
          child: ProfileStatCard(
            label: AppStaticStrings.totalRevenue,
            value: "12,450AED",
            icon: Icons.attach_money,
            iconColor: AppColors.kGreenColor,
          ),
        ),
        Expanded(
          child: ProfileStatCard(
            label: AppStaticStrings.totalOrders,
            value: "487",
            icon: Icons.trending_up,
            iconColor: AppColors.kPrimaryColor,
          ),
        ),
        Expanded(
          child: ProfileStatCard(
            label: AppStaticStrings.customers,
            value: "187",
            icon: Icons.people_outline,
            iconColor: AppColors.kSecondaryColor,
          ),
        ),
      ],
    );
  }
}
