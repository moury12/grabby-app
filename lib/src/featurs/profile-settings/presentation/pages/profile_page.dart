import '../../../../src_export.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              // Header
              ProfileHeader(
                name: "Sarah Mitchell",
                email: "sarah.mitchell@email.com",
                phone: "+1 (555) 123-4567",
                memberSince: "January 2024",
                onEditImage: () {
                  context.pushNamed(RoutesPath.personalInfoPath);
                },
              ),

              // Metric Card
              const ProfileMetricCard(
                icon: ImagesConstant.kRewardIcon,
                value: "47",
                label: "Orders",
              ),

              // Menu List
              Column(
                children: [
                  ProfileMenuTile(
                    icon: ImagesConstant.kProfileIcon,
                    title: AppStaticStrings.personalInformation,
                    onTap: () => context.pushNamed(RoutesPath.personalInfoPath),
                  ),
                  ProfileMenuTile(
                    icon: ImagesConstant.kCartIcon,
                    title: AppStaticStrings.cart,
                    onTap: () => context.pushNamed(RoutesPath.cartPath),
                  ),
                  ProfileMenuTile(
                    icon: ImagesConstant.kCardIcon,
                    title: AppStaticStrings.paymentMethods,
                    onTap: () {
                      // Navigate to payment methods
                    },
                  ),
                  ProfileMenuTile(
                    icon: ImagesConstant.kCarIcon,
                    title: AppStaticStrings.carPlates,
                    onTap: () => context.pushNamed(RoutesPath.carPlatesPath),
                  ),
                ],
              ),

              // Preferences Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const CustomText(
                    AppStaticStrings.preferences,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kSecondaryTextColor,
                  ),
                  ProfileMenuTile(
                    icon: ImagesConstant.kNotificationIcon,
                    title: AppStaticStrings.notifications,
                    onTap: () => context.pushNamed(RoutesPath.notificationPath),
                  ),
                  ProfileMenuTile(
                    icon: ImagesConstant.kSettingsIcon,
                    title: AppStaticStrings.settings,
                    onTap: () =>
                        context.pushNamed(RoutesPath.accountSettingsPath),
                  ),
                ],
              ),
              space24H,
            ],
          ),
        ),
      ),
    );
  }
}
