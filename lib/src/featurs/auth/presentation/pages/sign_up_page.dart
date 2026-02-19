import '../../../../src_export.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.getPadding12(context).copyWith(top: 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                CustomText(
                  AppStaticStrings.signUp,
                  variant: TextVariant.headlineLarge,
                ),

                CustomText(
                  AppStaticStrings.letsGetYouSetUp,
                  variant: TextVariant.titleSmall,
                  color: AppColors.kBlueColor,
                ),
                space6H,
                CustomTextField(
                  title: AppStaticStrings.preferredName,
                  hintText: AppStaticStrings.preferredName,
                ),
                CustomTextField(
                  title: AppStaticStrings.email,
                  hintText: AppStaticStrings.email,
                ),
                CustomTextField(
                  title: AppStaticStrings.phoneNumber,
                  hintText: AppStaticStrings.phoneNumber,
                  keyboardType: TextInputType.phone,
                  textEditingController: TextEditingController(text: "+971"),
                ),
                CustomTextField(
                  title: AppStaticStrings.password,
                  hintText: AppStaticStrings.password,
                  isPassword: true,
                ),
                CustomTextField(
                  title: AppStaticStrings.confirmPassword,
                  hintText: AppStaticStrings.confirmPassword,
                  isPassword: true,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    Expanded(
                      child: Wrap(
                        children: [
                          CustomText(AppStaticStrings.iHaveReadAndAgree),
                          ButtonTapWidget(
                            onTap: () {
                              // TODO: Navigate to Terms and Conditions
                            },
                            child: CustomText(
                              AppStaticStrings.termsAndConditions,
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                          CustomText(AppStaticStrings.and),
                          ButtonTapWidget(
                            onTap: () {
                              // TODO: Navigate to Privacy Policy
                            },
                            child: CustomText(
                              AppStaticStrings.privacyPolicy,
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                CustomButton(
                  text: AppStaticStrings.signUp,
                  onPressed: () {
                    context.pushNamed(RoutesPath.verificationPath);
                  },
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   spacing: 4,
                //   children: [
                //     CustomText("don't Have an Account?", variant: TextVariant.labelMedium,),
                //     ButtonTapWidget(
                //       onTap: () {
                //         context.pushNamed(RoutesPath.signUpPath);
                //       },
                //       child: CustomText(AppStaticStrings.signUp, color: AppColors.kPrimaryColor, variant: TextVariant.labelMedium,),
                //     )
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
