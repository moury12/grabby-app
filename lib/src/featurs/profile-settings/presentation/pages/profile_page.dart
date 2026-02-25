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
                icon: ImagesConstant.kGiftIcon,
                value: "47",
                label: "Orders",
              ),

              // Menu List
              Column(
                spacing: 8,
                children: [
                  ProfileMenuTile(
                    icon: ImagesConstant.kProfileIcon,
                    title: AppStaticStrings.personalInformation,
                    onTap: () => context.pushNamed(RoutesPath.personalInfoPath),
                  ),
                  // ProfileMenuTile(
                  //   icon: ImagesConstant.kCartIcon,
                  //   title: AppStaticStrings.cart,
                  //   onTap: () => context.pushNamed(RoutesPath.cartPath),
                  // ),
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
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
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
                  ProfileMenuTile(
                    icon: ImagesConstant.kLocationIcon,
                    title: AppStaticStrings.suggestAShop,
                    onTap: () => context.pushNamed(RoutesPath.suggestAShopPath),
                  ),
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
              space24H,
            ],
          ),
        ),
      ),
    );
  }
}
