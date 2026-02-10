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
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge?.copyWith(color: AppColors.kPrimaryColor),
              ),
            ],
          ),
        ),
        'subtitle': AppStaticStrings.orderYourFavoriteCoffee,
        'img': ImagesConstant.kOnboard1Img,
      },
      {
        'title':CustomText(
          AppStaticStrings.findTheBestCafe,
          variant: TextVariant.headlineLarge,
          color: AppColors.kWhiteTextColor,
        ),
        'subtitle': AppStaticStrings.searchExploreMenu,
        'img': ImagesConstant.kOnboard2Img,
      }, {
        'title':CustomText(
          AppStaticStrings.findTheBestCafe,
          variant: TextVariant.headlineLarge,
          color: AppColors.kWhiteTextColor,
        ),
        'subtitle': AppStaticStrings.searchExploreMenu,
        'img': ImagesConstant.kOnboard3Img,
      },{
        'title':CustomText(
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
        return Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Positioned.fill(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withValues(alpha: 0.6),
                  BlendMode.darken,
                ),
                child: Image.asset(item['img'], fit: BoxFit.cover),
              ),
            ),
            Positioned(
              bottom: MediaQuery.sizeOf(context).height / 7,
              left: 0,
              right: 0,
              child: Padding(
                padding: AppPadding.getPadding12(context),
                child: Column(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    item['title'],
                    CustomText(
                      item['subtitle'],
                      color: AppColors.kWhiteTextColor,
                      textAlign: TextAlign.center,
                    ),
                    space4H,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 4,
                      children: List.generate(
                        onboardingData.length,
                        (index) => Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          height: 10,
                          width: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      itemCount: onboardingData.length,
    );
  }
}


