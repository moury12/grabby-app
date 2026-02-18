import '../../../../src_export.dart';

class PersonalInformationPage extends StatelessWidget {
  const PersonalInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStaticStrings.personalInformation)),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context).copyWith(top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            // Profile Photo Section
            const CustomText(
              AppStaticStrings.profilePhoto,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.kSecondaryTextColor,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                spacing: 12,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: AssetImage(ImagesConstant.kOnboard1Img),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        right: -10,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppColors.kPrimaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const CustomText(
                    AppStaticStrings.changePhoto,
                    fontSize: 14,
                    color: AppColors.kPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),

            // Basic Information Section
            const CustomText(
              AppStaticStrings.basicInformation,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.kSecondaryTextColor,
            ),

            _buildField(
              label: AppStaticStrings.name,
              hint: "Sarah",
              icon: Icons.person_outline,
            ),

            _buildField(
              label: AppStaticStrings.emailAddress,
              hint: "sarahjahan@gmail.com",
              icon: Icons.email,
            ),

            _buildField(
              label: AppStaticStrings.phoneNumber,
              hint: "+(971) 111 332 324",
              icon: Icons.call,
            ),

            _buildField(
              label: AppStaticStrings.dateOfBirth,
              hint: "DD/MM/YYYY",
              icon: Icons.calendar_today_outlined,
            ),

            CustomButton(
              text: AppStaticStrings.saveChange,
              onPressed: () {},
              backgroundColor: AppColors.kPrimaryColor,
              borderRadius: 12,
            ),

            CustomButton(
              text: AppStaticStrings.cancel,
              onPressed: () => context.pop(),
              backgroundColor: Colors.white,
              textColor: AppColors.kSecondaryTextColor,
              borderColor: Colors.black12,
              borderRadius: 12,
            ),
            space24H,
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return CustomTextField(
      hintText: hint,
      title: label,
      prefixIcon: Icon(icon, color: AppColors.kSecondaryTextColor, size: 20),
    );
  }
}
