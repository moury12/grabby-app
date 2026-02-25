import '../../../../src_export.dart';

class RequiredDocumentsPage extends StatelessWidget {
  const RequiredDocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          AppStaticStrings.requiredDocuments,
          variant: TextVariant.titleLarge,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const OnboardingProgressBar(currentStep: 3),
            Padding(
              padding: AppPadding.getPadding12(context),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    AppStaticStrings.requiredDocuments,
                    variant: TextVariant.titleMedium,
                    fontWeight: FontWeight.bold,
                  ),
                  DocumentUploadCard(
                    title: AppStaticStrings.businessLicense,
                    subtitle: AppStaticStrings.pdfJpgPngMax5MB,
                    onUpload: () {},
                  ),
                  DocumentUploadCard(
                    title: AppStaticStrings.cafeLogo,
                    subtitle: AppStaticStrings.pdfJpgPngMax5MB,
                    onUpload: () {},
                  ),

                  CustomButton(
                    text: AppStaticStrings.continueText,
                    onPressed: () {
                      context.goNamed(RoutesPath.shopNavigationPath);
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
}
