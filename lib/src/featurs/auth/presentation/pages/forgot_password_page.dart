import '../../../../src_export.dart';


class ForgotPasswordPage extends StatelessWidget {

  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStaticStrings.forgotPassword)),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.getPadding12(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(ImagesConstant.kForgetPassImg),
              space12H,
              CustomText(AppStaticStrings.enterYourEmail, variant: TextVariant.labelLarge, color: AppColors.kSecondaryTextColor, textAlign: TextAlign.center,),
              space12H,
              CustomTextField(
                title: AppStaticStrings.email,
                hintText: AppStaticStrings.enterYourEmailHint,
              ),
              space12H,
              CustomButton(
                text: AppStaticStrings.sendCode,
                onPressed: () {
                  context.pushNamed(RoutesPath.verificationPath, extra: RoutesPath.forgotPasswordPath);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
