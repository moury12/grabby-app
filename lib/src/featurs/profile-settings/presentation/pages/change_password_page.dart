import '../../../../src_export.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        title: const Text(AppStaticStrings.changePassword),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            _buildField(label: AppStaticStrings.typePassword, hint: "••••••••"),
            _buildField(label: AppStaticStrings.newPassword, hint: "••••••••"),
            _buildField(
              label: AppStaticStrings.newConfirmPassword,
              hint: "••••••••",
            ),

            space24H,
            CustomButton(
              text: AppStaticStrings.update,
              onPressed: () {},
              backgroundColor: AppColors.kPrimaryColor,
              borderRadius: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({required String label, required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        CustomText(label, fontSize: 14, fontWeight: FontWeight.w500),
        CustomTextField(
          hintText: hint,
          suffixIcon: const Icon(
            Icons.visibility_off_outlined,
            color: AppColors.kSecondaryTextColor,
            size: 20,
          ),
          isPassword: true,
        ),
      ],
    );
  }
}
