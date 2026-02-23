import '../../../../src_export.dart';

class ShopHomeHeader extends StatelessWidget {
  const ShopHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              AppStaticStrings.brewAndCo,
              variant: TextVariant.headlineMedium,
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              AppStaticStrings.downtownBranch,
              variant: TextVariant.bodyMedium,
              color: AppColors.kSecondaryTextColor,
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Stack(
            children: [
              SvgPicture.asset(
                ImagesConstant.kNotificationIcon,
                height: 24,
                width: 24,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.kRedColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
