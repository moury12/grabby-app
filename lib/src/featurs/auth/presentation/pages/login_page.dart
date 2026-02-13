
import '../../../../src_export.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStaticStrings.loginAccount),),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.getPadding12(context),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing:12,
              children: [
                SvgPicture.asset(ImagesConstant.kLoginImg),
                CustomText(AppStaticStrings.gladToMeetYouAgain,variant: TextVariant.headlineLarge,),
                space6H,
                CustomTextField(
                  title: AppStaticStrings.emailAddressOrPhoneNumber,
                  hintText: AppStaticStrings.emailAddressOrPhoneNumber,
                ),
                CustomTextField(
                  title: AppStaticStrings.password,
                  hintText: AppStaticStrings.password,
                  isPassword: true,
                ),
        Align(
          alignment: AlignmentGeometry.topRight,
          child: ButtonTapWidget(
            onTap: () {
        context.pushNamed(RoutesPath.forgotPasswordPath);
            },
        child: CustomText(AppStaticStrings.forgotThePassword, color: AppColors.kSecondaryColor,variant: TextVariant.titleSmall,)),
        ),
                
                CustomButton(text: AppStaticStrings.logIn, onPressed: () {
context.pushNamed(RoutesPath.navigationPath);
                },),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 4,
                  children: [
                    CustomText("don't Have an Account?", variant: TextVariant.labelMedium,),
                    ButtonTapWidget(
                      onTap: () {
                        context.pushNamed(RoutesPath.signUpPath);
                      },
                      child: CustomText(AppStaticStrings.signUp, color: AppColors.kPrimaryColor, variant: TextVariant.labelMedium,),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
