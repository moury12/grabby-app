import 'dart:ui';
import '../../../../src_export.dart';

class CafeCardWidget extends StatelessWidget {
  final String title;
  final String image;
  final String distance;
  final String openHours;
  final bool isOpen;
  final List<String> tags;

  const CafeCardWidget({
    super.key,
    required this.title,
    required this.image,
    required this.distance,
    required this.openHours,
    this.isOpen = true,
    this.tags = const ["Car", "Counter"],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          // Distance Tag
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: CustomText(
                distance,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          // Blurry Bottom Section
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: double.infinity,
                  padding: AppPadding.getPadding12(context),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: .3),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomText(
                              title,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.kGreenColor.withValues(
                                alpha: .2,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.kGreenColor.withValues(
                                  alpha: .5,
                                ),
                              ),
                            ),
                            child: CustomText(
                              isOpen
                                  ? AppStaticStrings.openNow
                                  : AppStaticStrings.closed,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.kGreenColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        spacing: 8,
                        children: tags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: .2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: .3),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  tag == "Car"
                                      ? Icons.directions_car_filled_outlined
                                      : Icons.person_2_outlined,
                                  size: 14,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 4),
                                CustomText(
                                  tag,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_filled,
                            size: 16,
                            color: AppColors.kGreenColor,
                          ),
                          const SizedBox(width: 6),
                          CustomText(
                            "${AppStaticStrings.open} $openHours",
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kGreenColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
