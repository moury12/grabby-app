import 'package:grabby_app/src/core/utils/launcher_utils.dart';
import 'package:grabby_app/src/featurs/home/presentation/bloc/shop_dashboard_bloc.dart';
import 'package:grabby_app/src/featurs/support/presentation/bloc/support_bloc.dart';
import 'package:grabby_app/src/featurs/profile-settings/presentation/bloc/stripe_connect/stripe_connect_bloc.dart';
import 'package:grabby_app/src/featurs/profile-settings/data/models/stripe_connect_model.dart';

import '../../../../src_export.dart';

class BusinessProfilePage extends StatelessWidget {
  const BusinessProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ProfileBloc>()..add(GetProfileEvent()),
        ),
        BlocProvider(
          create: (context) => sl<SupportBloc>()..add(GetHelpCenterEvent()),
        ),
        BlocProvider(
          create: (context) =>
              sl<StripeConnectBloc>()..add(FetchStripeConnectStatusEvent()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            AppStaticStrings.businessProfile,
            variant: TextVariant.headlineSmall,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              final profile = state.profileData;
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ProfileBloc>().add(GetProfileEvent());
                  context.read<SupportBloc>().add(GetHelpCenterEvent());
                  context
                      .read<StripeConnectBloc>()
                      .add(FetchStripeConnectStatusEvent());
                },
                child: SingleChildScrollView(
                  padding: AppPadding.getPadding12H(context),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    spacing: 6,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBusinessHeader(context, profile),
                      space2H,
                      _buildStatsRow(context),
                      space2H,
                      _buildPayoutCard(context),
                      space2H,
                      ProfileMenuItem(
                        title: AppStaticStrings.branchManagement,
                        icon: Icons.store_outlined,
                        onTap: () =>
                            context.pushNamed(RoutesPath.branchManagementName),
                      ),
                      Divider(color: Colors.white, height: 1),
                      ProfileMenuItem(
                        title: AppStaticStrings.branchTimings,
                        icon: Icons.location_on_outlined,
                        onTap: () =>
                            context.pushNamed(RoutesPath.branchTimingsName),
                      ),
                      Divider(color: Colors.white, height: 1),
                      // ProfileMenuItem(
                      //   title: AppStaticStrings.marketingCampaigns,
                      //   icon: Icons.campaign_outlined,
                      //   onTap: () => context.pushNamed(
                      //     RoutesPath.marketingCampaignsName,
                      //   ),
                      // ),
                      Divider(color: Colors.white, height: 1),
                      ProfileMenuItem(
                        title: AppStaticStrings.settings,
                        icon: Icons.settings_outlined,
                        onTap: () =>
                            context.pushNamed(RoutesPath.accountSettingsPath),
                      ),
                      Divider(color: Colors.white, height: 1),
                      ProfileMenuItem(
                        title: AppStaticStrings.notifications,
                        icon: Icons.notifications_none_outlined,
                        onTap: () =>
                            context.pushNamed(RoutesPath.notificationPath),
                      ),
                      // Divider(color: Colors.white, height: 1),
                      // ProfileMenuItem(
                      //   title: AppStaticStrings.rewardSettings,
                      //   icon: Icons.card_giftcard_outlined,
                      //   onTap: () => context.pushNamed(RoutesPath.rewardSettingsName),
                      // ),
                      Divider(color: Colors.white, height: 1),
                      BlocListener<SupportBloc, SupportState>(
                        listener: (context, state) {
                          if (state is SupportError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        child: ProfileMenuItem(
                          title: AppStaticStrings.helpCenter,
                          icon: Icons.help_outline,
                          onTap: () {
                            final state = context.read<SupportBloc>().state;
                            if (state is HelpCenterLoaded &&
                                state.data.isNotEmpty) {
                              LauncherUtils.makePhoneCall(
                                state.data.first.phone,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Help center contact not available",
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Divider(color: Colors.white, height: 1),
                      ProfileMenuItem(
                        title: AppStaticStrings.termsAndConditions,
                        icon: Icons.description_outlined,
                        onTap: () => context.pushNamed(
                          RoutesPath.termsAndConditionsPath,
                        ),
                      ),
                      Divider(color: Colors.white, height: 1),
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
                ),
              );
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildBusinessHeader(BuildContext context, ProfileData profile) {
    return Container(
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
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
                imageUrl: profile.profileImage != null
                    ? "${ApiEndpoints.baseUrl}${profile.profileImage}"
                    : "",
                width: 60,
                height: 60,
                radius: 12,
                imageErrorUrl: ImagesConstant.kOnboard1Img,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      profile.shopName ?? profile.name,
                      variant: TextVariant.titleLarge,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      profile.authId.role.replaceAll('_', ' '),
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
                child: const Icon(Icons.edit_outlined),
              ),
            ],
          ),
          CustomText(
            profile.email,
            variant: TextVariant.labelMedium,
            color: Colors.white,
          ),
          CustomText(
            profile.phoneNumber,
            variant: TextVariant.labelMedium,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return BlocBuilder<ShopDashboardBloc, ShopDashboardState>(
      builder: (context, state) {
        final stats = state.stats;
        return Row(
          spacing: 6,
          children: [
            Expanded(
              child: ProfileStatCard(
                label: AppStaticStrings.totalRevenue,
                value:
                    "AED ${stats?.totalRevenue.toStringAsFixed(2) ?? "0.00"}",
                icon: Icons.attach_money,
                iconColor: AppColors.kGreenColor,
              ),
            ),
            Expanded(
              child: ProfileStatCard(
                label: AppStaticStrings.totalOrders,
                value: "${stats?.totalOrders ?? 0}",
                icon: Icons.trending_up,
                iconColor: AppColors.kPrimaryColor,
              ),
            ),
            Expanded(
              child: ProfileStatCard(
                label: AppStaticStrings.customers,
                value: "${stats?.totalUniqueCustomers ?? 0}",
                icon: Icons.people_outline,
                iconColor: AppColors.kSecondaryColor,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPayoutCard(BuildContext context) {
    return BlocConsumer<StripeConnectBloc, StripeConnectState>(
      listener: (context, state) async {
        if (state is StripeOnboardingLinkGenerated) {
          final result = await context.pushNamed<bool>(
            RoutesPath.stripeConnectWebviewPath,
            extra: state.url,
          );
          if (result == true && context.mounted) {
            context.read<StripeConnectBloc>().add(FetchStripeConnectStatusEvent());
          }
        } else if (state is StripeConnectError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        StripeConnectStatusModel? status;
        bool isLoading = state is StripeConnectLoading;
        if (state is StripeConnectLoaded) {
          status = state.status;
        } else if (state is StripeOnboardingLinkGenerated) {
          status = state.currentStatus;
        }

        final isConnected = status?.stripeAccountConnected ?? false;
        final bankDetails = status?.bankDetails;

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(appRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.account_balance_outlined,
                          color: AppColors.kPrimaryColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const CustomText(
                        "Payout Bank Account",
                        variant: TextVariant.titleMedium,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isConnected
                          ? AppColors.kGreenColor.withValues(alpha: 0.15)
                          : Colors.orange.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isConnected
                              ? Icons.check_circle
                              : Icons.warning_amber_rounded,
                          size: 14,
                          color: isConnected
                              ? AppColors.kGreenColor
                              : Colors.orange.shade800,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isConnected ? "Connected" : "Not Connected",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isConnected
                                ? AppColors.kGreenColor
                                : Colors.orange.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (isConnected && bankDetails != null) ...[
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.kBackgroundColor.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      _buildBankDetailRow(
                          "Bank Name", bankDetails.bankName ?? "N/A"),
                      const SizedBox(height: 4),
                      _buildBankDetailRow(
                          "Account Holder", bankDetails.accountHolderName ?? "N/A"),
                      const SizedBox(height: 4),
                      _buildBankDetailRow(
                        "Account Number",
                        bankDetails.accountNumberLast4 != null
                            ? "•••• ${bankDetails.accountNumberLast4}"
                            : "N/A",
                      ),
                      const SizedBox(height: 4),
                      _buildBankDetailRow(
                        "Currency",
                        (bankDetails.currency ?? "AED").toUpperCase(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {
                      context
                          .read<StripeConnectBloc>()
                          .add(GetStripeOnboardingLinkEvent());
                    },
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text("Manage Bank Account"),
                  ),
                ),
              ] else ...[
                const CustomText(
                  "Link your IBAN / bank account via Stripe Connect to receive automated 90% payouts on completed orders.",
                  variant: TextVariant.bodySmall,
                  color: Colors.grey,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: "Connect Bank Account",
                    onPressed: () {
                      context
                          .read<StripeConnectBloc>()
                          .add(GetStripeOnboardingLinkEvent());
                    },
                    icon: Icons.open_in_new,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildBankDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
