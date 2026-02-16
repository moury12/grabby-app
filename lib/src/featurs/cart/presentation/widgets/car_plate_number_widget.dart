import '../../../../src_export.dart';

class CarPlateNumberWidget extends StatelessWidget {
  final String plateNumber;
  final VoidCallback onTap;

  const CarPlateNumberWidget({
    super.key,
    required this.plateNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        const CustomText(
          AppStaticStrings.carPlateNumber,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        ButtonTapWidget(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F2FF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  ImagesConstant.kCarIcon,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomText(
                    plateNumber,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
