import '../../../../src_export.dart';

class CategoriesManagementBottomSheet extends StatefulWidget {
  const CategoriesManagementBottomSheet({super.key});

  @override
  State<CategoriesManagementBottomSheet> createState() =>
      _CategoriesManagementBottomSheetState();
}

class _CategoriesManagementBottomSheetState
    extends State<CategoriesManagementBottomSheet> {
  final List<String> categories = ["Matcha", "Hot Coffee", "Cold Coffee"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding12(
        context,
      ).copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 19),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                AppStaticStrings.categories,
                variant: TextVariant.titleLarge,
                fontWeight: FontWeight.bold,
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),

          ...categories.map((cat) => _buildCategoryRow(cat)),

          CustomTextField(
            hintText: AppStaticStrings.categoryName,
            fillColor: const Color(0xffF9FAFB),
            borderRadius: 12,
          ),
          space4H,
          CustomButton(
            text: AppStaticStrings.submit,
            onPressed: () {},
            backgroundColor: AppColors.kPrimaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(name, fontWeight: FontWeight.w600),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.delete, color: Colors.red),
        ),
      ],
    );
  }
}
