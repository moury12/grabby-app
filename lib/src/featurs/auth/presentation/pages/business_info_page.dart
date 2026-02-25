import '../../../../src_export.dart';

class BusinessInfoPage extends StatelessWidget {
  const BusinessInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          AppStaticStrings.businessInformation,
          variant: TextVariant.titleLarge,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const OnboardingProgressBar(currentStep: 1),
            Padding(
              padding: AppPadding.getPadding12(context),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    AppStaticStrings.businessInformation,
                    variant: TextVariant.titleMedium,
                    fontWeight: FontWeight.bold,
                  ),
                  _buildField(
                    context,
                    label: AppStaticStrings.cafeName,
                    hint: AppStaticStrings.enterYourCafeName,
                  ),
                  _buildField(
                    context,
                    label: AppStaticStrings.shopLicenseNumber,
                    hint: AppStaticStrings
                        .enterYourCafeName, // Using name hint as per UI image
                  ),
                  _buildField(
                    context,
                    label: AppStaticStrings.contactEmail,
                    hint: AppStaticStrings.businessEmailHint,
                    icon: Icons.email_outlined,
                  ),
                  _buildField(
                    context,
                    label: AppStaticStrings.contactPhone,
                    hint: AppStaticStrings.phoneHint,
                    icon: Icons.phone_outlined,
                  ),

                  CustomButton(
                    text: AppStaticStrings.continueText,
                    onPressed: () {
                      context.push(RoutesPath.branchLocationsPath);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    BuildContext context, {
    required String label,
    required String hint,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        CustomText(
          label,
          variant: TextVariant.labelLarge,
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          hintText: hint,
          prefixIcon: icon != null
              ? Icon(icon, color: Colors.grey, size: 20)
              : null,
        ),
      ],
    );
  }
}
