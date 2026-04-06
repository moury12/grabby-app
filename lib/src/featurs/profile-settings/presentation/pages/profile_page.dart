import '../../../../src_export.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileBloc>()..add(GetProfileEvent()),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileError) {
                return Center(child: Text(state.message));
              } else if (state is ProfileLoaded) {
                final profile = state.profileData;
                final memberSince = DateFormat('MMMM yyyy').format(profile.createdAt);

                return SingleChildScrollView(
                  padding: AppPadding.getPadding12(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      // Header
                      ProfileHeader(
                        name: profile.name,
                        email: profile.email,
                        phone: profile.phoneNumber,
                        memberSince: memberSince,
                        onEditImage: () {
                          context.pushNamed(RoutesPath.personalInfoPath);
                        },
                      ),

                      // Metric Card
                      const ProfileMetricCard(
                        icon: ImagesConstant.kGiftIcon,
                        value: "0", // TODO: Get from backend if available
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
                            onTap: () => context.pushNamed(RoutesPath.accountSettingsPath),
                          ),
                          ProfileMenuTile(
                            icon: ImagesConstant.kLocationIcon,
                            title: AppStaticStrings.suggestAShop,
                            onTap: () => context.pushNamed(RoutesPath.suggestAShopPath),
                          ),
                          CustomButton(
                            text: AppStaticStrings.logOut,
                            onPressed: () async {
                              await sl<LocalStorageService>().clearAuthData();
                              if (context.mounted) {
                                context.goNamed(RoutesPath.loginPath);
                              }
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
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
