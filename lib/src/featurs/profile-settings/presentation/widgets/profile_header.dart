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
          // Stack(
          //   children: [
          //     Container(
          //       width: 80,
          //       height: 80,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(12),
          //         image: imageUrl != null
          //             ? DecorationImage(
          //                 image: NetworkImage(imageUrl!),
          //                 fit: BoxFit.cover,
          //               )
          //             : const DecorationImage(
          //                 image: AssetImage(
          //                   ImagesConstant.kOnboard1Img,
          //                 ), // Placeholder
          //                 fit: BoxFit.cover,
          //               ),
          //       ),
          //     ),
          //     Positioned(
          //       bottom: -5,
          //       right: -5,
          //       child: IconButton(
          //         onPressed: onEditImage,
          //         icon: Container(
          //           padding: const EdgeInsets.all(4),
          //           decoration: BoxDecoration(
          //             color: AppColors.kPrimaryColor,
          //             borderRadius: BorderRadius.circular(4),
          //           ),
          //           child: const Icon(
          //             Icons.edit_outlined,
          //             size: 16,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // space4H,
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
