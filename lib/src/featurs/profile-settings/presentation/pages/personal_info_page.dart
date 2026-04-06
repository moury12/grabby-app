import '../../../../src_export.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileBloc>()..add(GetProfileEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text(AppStaticStrings.personalInformation)),
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLoaded) {
              _nameController.text = state.profileData.name;
              _emailController.text = state.profileData.email;
              _phoneController.text = state.profileData.phoneNumber;
            }
          },
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileError) {
              return Center(child: Text(state.message));
            } else if (state is ProfileLoaded) {
              return SingleChildScrollView(
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
                                    image: AssetImage(
                                      ImagesConstant.kOnboard1Img,
                                    ),
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

                    CustomTextField(
                      textEditingController: _nameController,
                      title: AppStaticStrings.name,
                      hintText: AppStaticStrings.name,
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: AppColors.kSecondaryTextColor,
                        size: 20,
                      ),
                    ),

                    CustomTextField(
                      textEditingController: _emailController,
                      title: AppStaticStrings.emailAddress,
                      hintText: AppStaticStrings.emailAddress,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: AppColors.kSecondaryTextColor,
                        size: 20,
                      ),
                    ),

                    CustomTextField(
                      textEditingController: _phoneController,
                      title: AppStaticStrings.phoneNumber,
                      hintText: AppStaticStrings.phoneNumber,
                      prefixIcon: const Icon(
                        Icons.call_outlined,
                        color: AppColors.kSecondaryTextColor,
                        size: 20,
                      ),
                    ),

                    CustomButton(
                      text: AppStaticStrings.saveChange,
                      onPressed: () {
                        // TODO: Implement Update Profile
                      },
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
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
