import 'package:cached_network_image/cached_network_image.dart';
import '../../../../src_export.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String memberSince;
  final String? imageUrl;
  final VoidCallback onEditImage;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.memberSince,
    this.imageUrl,
    required this.onEditImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white.withValues(alpha: 0.1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: imageUrl != null && imageUrl!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Image(
                            image: AssetImage(ImagesConstant.kOnboard1Img),
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Image(
                          image: AssetImage(ImagesConstant.kOnboard1Img),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: onEditImage,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.edit_outlined,
                      size: 16,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          space12H,
          CustomText(
            name,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),

          CustomText(
            email,
            fontSize: 14,
            color: AppColors.kWhiteTextColor,
            fontWeight: FontWeight.w600,
          ),

          CustomText(
            phone,
            fontSize: 14,
            color: AppColors.kWhiteTextColor,
            fontWeight: FontWeight.w600,
          ),

          CustomText(
            "${AppStaticStrings.memberSince} $memberSince",
            fontSize: 12,
            color: AppColors.kWhiteTextColor,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
