import '../../../../src_export.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  void _showDeleteAccountDialog(BuildContext context, ProfileBloc bloc) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(AppStaticStrings.deleteAccount),
        content: const Text(AppStaticStrings.areYouSureDeleteAccount),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text(
              AppStaticStrings.cancel,
              style: TextStyle(color: AppColors.kSecondaryTextColor),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.kRedColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              bloc.add(DeleteAccountEvent());
            },
            child: const Text(AppStaticStrings.delete),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileBloc>(),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is DeleteAccountSuccess) {
            CustomSnackbar.show(context, state.message);
            context.goNamed(RoutesPath.loginPath);
          } else if (state is ProfileError) {
            CustomSnackbar.show(context, state.message, isError: true);
          }
        },
        builder: (context, state) {
          final isLoading = state is ProfileLoading;

          return Stack(
            children: [
              Scaffold(
                backgroundColor: AppColors.kBackgroundColor,
                appBar: AppBar(
                  title: const Text(AppStaticStrings.accountSettings),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back, color: AppColors.kTextColor),
                  ),
                ),
                body: SingleChildScrollView(
                  padding: AppPadding.getPadding12(context),
                  child: Column(
                    spacing: 12,
                    children: [
                      ProfileMenuTile(
                        isBackground: true,
                        icon: ImagesConstant.kPasswordIcon,
                        title: AppStaticStrings.changePassword,
                        onTap: () =>
                            context.pushNamed(RoutesPath.changePasswordPath),
                      ),
                      ProfileMenuTile(
                        isBackground: true,
                        icon: ImagesConstant.kDeleteAccIcon,
                        title: AppStaticStrings.deleteAccount,
                        onTap: () {
                          if (!isLoading) {
                            _showDeleteAccountDialog(
                              context,
                              context.read<ProfileBloc>(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              if (isLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
