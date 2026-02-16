import '../../../../src_export.dart';

class CarPlatesPage extends StatelessWidget {
  const CarPlatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStaticStrings.carPlates)),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          spacing: 12,
          children: [
            // Add New Plate Button
            ButtonTapWidget(
              onTap: () => context.pushNamed(RoutesPath.addCarPlatePath),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F2FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFA59BF9).withValues(alpha: 0.5),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: [
                    Icon(Icons.add, color: Color(0xFFA59BF9)),
                    CustomText(
                      AppStaticStrings.addNewPlate,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFA59BF9),
                    ),
                  ],
                ),
              ),
            ),

            // Plate List (Hardcoded for now)
            _buildPlateCard(context, plateNumber: "ABC 1234", isDefault: true),
            _buildPlateCard(context, plateNumber: "XYZ 5678", isDefault: false),
          ],
        ),
      ),
    );
  }

  Widget _buildPlateCard(
    BuildContext context, {
    required String plateNumber,
    required bool isDefault,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDefault
              ? const Color(0xFFA59BF9)
              : Colors.grey.withValues(alpha: 0.2),
          width: isDefault ? 1.5 : 1,
        ),
      ),
      child: Row(
        spacing: 12,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F2FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SvgPicture.asset(
              ImagesConstant.kCarIcon,
              height: 30,
              colorFilter: const ColorFilter.mode(
                Color(0xFFA59BF9),
                BlendMode.srcIn,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    CustomText(
                      plateNumber,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    if (isDefault)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFA59BF9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const CustomText(
                          AppStaticStrings.defaultText,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
                if (!isDefault)
                  const CustomText(
                    AppStaticStrings.setAsDefault,
                    fontSize: 14,
                    color: Color(0xFFA59BF9),
                  ),
              ],
            ),
          ),
          if (!isDefault)
            const Icon(Icons.delete_outline, color: Colors.red, size: 24),
        ],
      ),
    );
  }
}
