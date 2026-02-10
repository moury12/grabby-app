import '../../../../src_export.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> onboardingData = [
      {
        'title': RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Welcome  To ",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.kWhiteTextColor,
                ),
              ),
              TextSpan(
                text: "Grabby",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
        'subtitle': AppStaticStrings.orderYourFavoriteCoffee,
        'img': ImagesConstant.kOnboard1Img,
      },
      {
        'title': CustomText(
          AppStaticStrings.findTheBestCafe,
          variant: TextVariant.headlineLarge,
          color: AppColors.kWhiteTextColor,
        ),
        'subtitle': AppStaticStrings.searchExploreMenu,
        'img': ImagesConstant.kOnboard2Img,
      },
      {
        'title': CustomText(
          AppStaticStrings.findTheBestCafe,
          variant: TextVariant.headlineLarge,
          color: AppColors.kWhiteTextColor,
        ),
        'subtitle': AppStaticStrings.searchExploreMenu,
        'img': ImagesConstant.kOnboard3Img,
      },
      {
        'title': CustomText(
          AppStaticStrings.findTheBestCafe,
          variant: TextVariant.headlineLarge,
          color: AppColors.kWhiteTextColor,
        ),
        'subtitle': AppStaticStrings.searchExploreMenu,
        'img': ImagesConstant.kOnboard4Img,
      },
    ];
    return PageView.builder(
      allowImplicitScrolling: true,
      itemBuilder: (context, index) {
        Map<String, dynamic> item = onboardingData[index];
        return OnboardingItemWidget(item: item, onboardingData: onboardingData,index: index,);
      },
      itemCount: onboardingData.length,
    );
  }
}

