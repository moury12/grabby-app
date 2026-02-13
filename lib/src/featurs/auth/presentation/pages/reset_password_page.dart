import 'package:flutter/material.dart';
import '../../../../core/constants/app_static_strings.dart';
import '../../../../core/constants/padding_constant.dart';
import '../../../../core/constants/space_constant.dart';
import '../../../../core/widgets/widgets_export.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStaticStrings.resetPassword)),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.getPadding12(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                title: AppStaticStrings.enterNewPassword,
                hintText: AppStaticStrings.enterNewPassword,
                isPassword: true,
              ),
              space12H,
              CustomTextField(
                title: AppStaticStrings.confirmPassword,
                hintText: AppStaticStrings.confirmPassword,
                isPassword: true,
              ),
              space12H,
              CustomButton(
                text: AppStaticStrings.continueText,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
