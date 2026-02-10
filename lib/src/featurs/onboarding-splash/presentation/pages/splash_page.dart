
import '../../../../src_export.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: GestureDetector(
        onTap: () {
          context.go(RoutesPath.onboardingPath);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Image.asset(ImagesConstant.kAppIcon,height: MediaQuery.of(context).size.width/1.5,),
           CustomText("GRABBY",variant: TextVariant.displayMedium,
             color:AppColors.kPrimaryColor,
             )

            ],
          ),
      )),
    );
  }
}
