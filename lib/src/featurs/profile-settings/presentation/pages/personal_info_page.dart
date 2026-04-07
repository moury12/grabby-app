import 'dart:io';
import 'package:image_picker/image_picker.dart';
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
  final _addressNameController = TextEditingController();
  final _latController = TextEditingController();
  final _lonController = TextEditingController();
  
  File? _imageFile;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressNameController.dispose();
    _latController.dispose();
    _lonController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  void _onSave(BuildContext context) {
    context.read<ProfileBloc>().add(
          UpdateProfileEvent(
            name: _nameController.text,
            addressName: _addressNameController.text,
            lat: _latController.text,
            lon: _lonController.text,
            profileImage: _imageFile,
          ),
        );
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
              _addressNameController.text = state.profileData.addressName ?? "";
              _latController.text = state.profileData.lat ?? "";
              _lonController.text = state.profileData.lon ?? "";
            }
          },
          builder: (context, state) {
            final isLoading = state is ProfileLoading;

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProfileBloc>().add(GetProfileEvent());
              },
              child: state is ProfileError
                  ? Center(child: Text(state.message))
                  : SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
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
                                        image: _imageFile != null
                                            ? DecorationImage(
                                                image: FileImage(_imageFile!),
                                                fit: BoxFit.cover,
                                              )
                                            : state is ProfileLoaded &&
                                                    state.profileData
                                                            .profileImage !=
                                                        null
                                                ? DecorationImage(
                                                    image: NetworkImage(state
                                                        .profileData
                                                        .profileImage!),
                                                    fit: BoxFit.cover,
                                                  )
                                                : const DecorationImage(
                                                    image: AssetImage(
                                                      ImagesConstant
                                                          .kOnboard1Img,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: -10,
                                      right: -10,
                                      child: GestureDetector(
                                        onTap: _pickImage,
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
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: _pickImage,
                                  child: const CustomText(
                                    AppStaticStrings.changePhoto,
                                    fontSize: 14,
                                    color: AppColors.kPrimaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
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
                            isEnable: false, // Email usually read-only
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
                            isEnable: false, // Phone usually read-only
                            prefixIcon: const Icon(
                              Icons.call_outlined,
                              color: AppColors.kSecondaryTextColor,
                              size: 20,
                            ),
                          ),
                          
                          CustomTextField(
                            textEditingController: _addressNameController,
                            title: "Address Name",
                            hintText: "Enter address name",
                            prefixIcon: const Icon(
                              Icons.location_on_outlined,
                              color: AppColors.kSecondaryTextColor,
                              size: 20,
                            ),
                          ),
                          
                          Row(
                            spacing: 12,
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  textEditingController: _latController,
                                  title: "Latitude",
                                  hintText: "Lat",
                                  prefixIcon: const Icon(
                                    Icons.map_outlined,
                                    color: AppColors.kSecondaryTextColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: CustomTextField(
                                  textEditingController: _lonController,
                                  title: "Longitude",
                                  hintText: "Lon",
                                  prefixIcon: const Icon(
                                    Icons.map_outlined,
                                    color: AppColors.kSecondaryTextColor,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          CustomButton(
                            text: AppStaticStrings.saveChange,
                            isLoading: isLoading,
                            onPressed: () => _onSave(context),
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
          },
        ),
      ),
    );
  }
}
