import 'package:grabby_app/src/core/widgets/custom_text_field.dart';

import '../../../../src_export.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStaticStrings.loginAccount),),
      body: Padding(
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

              space4H,
              CustomButton(text: AppStaticStrings.logIn, onPressed: () {

              },)
            ],
          ),
        ),
      )
    );
  }
}
