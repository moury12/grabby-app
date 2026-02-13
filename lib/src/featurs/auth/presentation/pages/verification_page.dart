import '../../../../src_export.dart';

import 'package:pinput/pinput.dart';

class VerificationPage extends StatelessWidget {
  final String? extra;
  const VerificationPage({super.key, this.extra});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(AppStaticStrings.verification)),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.getPadding12(context),
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                AppStaticStrings.verifyYourAccount,
                variant: TextVariant.headlineLarge,
              ),
              CustomText(
                AppStaticStrings.sentVerificationCode,
                variant: TextVariant.labelMedium,
                textAlign: TextAlign.center,
                color: AppColors.kSecondaryTextColor,
              ),

              SvgPicture.asset(ImagesConstant.kVerifyAccImg),

              space4H,

              /// 🔹 OTP FIELD
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,

                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 1.5,
                    ),
                    color: Colors.transparent,
                  ),
                ),
                onCompleted: (pin) {
                  // print("Entered OTP: $pin");
                },
              ),

              space4H,

              CustomButton(
                text: AppStaticStrings.verifyCode,
                onPressed: () {
                  if(extra==RoutesPath.forgotPasswordPath){
                    context.pushNamed(RoutesPath.resetPasswordPath);
                  }
                  else{
                    context.pushNamed(RoutesPath.locationPath);
                  }
                },
              ),
              ButtonTapWidget(
                child: CustomText(
                  AppStaticStrings.didntGetCode,
                  variant: TextVariant.labelMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
