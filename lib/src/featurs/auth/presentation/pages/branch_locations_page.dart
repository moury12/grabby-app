import '../../../../src_export.dart';

class BranchLocationsPage extends StatelessWidget {
  const BranchLocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          AppStaticStrings.branchLocations,
          variant: TextVariant.titleLarge,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const OnboardingProgressBar(currentStep: 2),
            Padding(
              padding: AppPadding.getPadding12(context),
              child: Column(
                // spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    AppStaticStrings.branchLocations,
                    variant: TextVariant.titleMedium,
                    fontWeight: FontWeight.bold,
                  ),
                  const CustomText(
                    AppStaticStrings.branch1,
                    variant: TextVariant.labelLarge,
                    fontWeight: FontWeight.bold,
                  ),
                  space8H,
                  const CustomTextField(
                    hintText: AppStaticStrings.branchNameHint,
                  ),
                  space8H,
                  const CustomTextField(hintText: AppStaticStrings.fullAddress),
                  space8H,
                  const CustomTextField(hintText: AppStaticStrings.phoneNumber),
                  space8H,
                  CustomButton(
                    text: AppStaticStrings.addAnotherBranch,
                    onPressed: () {},
                    icon: Icons.add,
                    isOutlined: true,
                    borderColor: AppColors.kPrimaryColor,
                    textColor: AppColors.kPrimaryColor,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (val) {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const Expanded(
                        child: CustomText(
                          AppStaticStrings.applySameMenuForAllBranches,
                          variant: TextVariant.labelSmall,
                          color: AppColors.kSecondaryTextColor,
                        ),
                      ),
                    ],
                  ),

                  CustomButton(
                    text: AppStaticStrings.continueText,
                    onPressed: () {
                      context.push(RoutesPath.requiredDocumentsPath);
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
