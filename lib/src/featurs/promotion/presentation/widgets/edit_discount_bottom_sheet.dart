import 'dart:io';
import '../../../../src_export.dart';

class EditDiscountBottomSheet extends StatefulWidget {
  final String? title;
  const EditDiscountBottomSheet({super.key, this.title});

  @override
  State<EditDiscountBottomSheet> createState() =>
      _EditDiscountBottomSheetState();
}

class _EditDiscountBottomSheetState extends State<EditDiscountBottomSheet> {
  final List<String> menuItems = [
    "Cappuccino",
    "Latte",
    "Americano",
    "Croissant",
    "Muffin",
    "Espresso",
    "Flat White",
  ];

  final Set<String> selectedItems = {"Cappuccino"};
  bool isDropdownOpen = false;
  File? _pickedImage;

  void toggleSelection(String item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding16(context),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 6,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                widget.title ?? AppStaticStrings.editDiscount,
                variant: TextVariant.headlineSmall,
                fontWeight: FontWeight.bold,
              ),
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),

          _buildFieldLabel(AppStaticStrings.promotionImage),
          _buildImagePicker(),

          _buildFieldLabel(AppStaticStrings.discountName),
          const CustomTextField(hintText: "Cappuccino"),

          _buildFieldLabel(AppStaticStrings.eventOccasionOptional),
          const CustomTextField(hintText: ""),

          Row(
            spacing: 6,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(AppStaticStrings.startDate),
                    const CustomTextField(hintText: ""),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(AppStaticStrings.endDate),
                    const CustomTextField(hintText: ""),
                  ],
                ),
              ),
            ],
          ),

          _buildFieldLabel(AppStaticStrings.appliedToItem),
          _buildMultiSelectField(),
          if (isDropdownOpen) _buildItemsList(),
          _buildFieldLabel(AppStaticStrings.discountPercentage),
          const CustomTextField(hintText: ""),

          // Container(
          //   padding: const EdgeInsets.all(12),
          //   decoration: BoxDecoration(
          //     color: AppColors.kBackgroundColor,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Row(
          //     spacing: 6,
          //     children: [
          //       Expanded(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             CustomText(
          //               AppStaticStrings.discountPercentage,
          //               variant: TextVariant.titleSmall,
          //               fontWeight: FontWeight.bold,
          //             ),
          //             CustomText(
          //               AppStaticStrings.makeDiscountActiveRightAway,
          //               variant: TextVariant.labelSmall,
          //               color: AppColors.kSecondaryTextColor,
          //             ),
          //           ],
          //         ),
          //       ),
          //       Switch(
          //         value: true,
          //         onChanged: (val) {},
          //         activeColor: AppColors.kPrimaryColor,
          //       ),
          //     ],
          //   ),
          // ),
          CustomButton(
            text: widget.title != null
                ? AppStaticStrings.addPromotion
                : AppStaticStrings.saveChanges,
            onPressed: () => context.pop(),
          ),

          CustomButton(
            text: AppStaticStrings.cancel,
            onPressed: () => context.pop(),
            isOutlined: true,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: CustomText(
        label,
        variant: TextVariant.labelMedium,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: () async {
        final File? image = await ImagePickerHelper.pickImage(context);
        if (image != null) {
          setState(() {
            _pickedImage = image;
          });
        }
      },
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.kBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.kSecondaryTextColor.withValues(alpha: 0.3),
          ),
        ),
        child: _pickedImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  _pickedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    color: AppColors.kPrimaryColor,
                    size: 40,
                  ),
                  SizedBox(height: 8),
                  CustomText(
                    "Click to upload image",
                    variant: TextVariant.labelSmall,
                    color: AppColors.kSecondaryTextColor,
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildMultiSelectField() {
    return GestureDetector(
      onTap: () => setState(() => isDropdownOpen = !isDropdownOpen),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.kSecondaryTextColor.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: selectedItems.isEmpty
                  ? CustomText(
                      "Select items",
                      variant: TextVariant.labelMedium,
                      color: AppColors.kSecondaryTextColor,
                    )
                  : Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: selectedItems
                          .map(
                            (item) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.kPrimaryColor.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText(
                                    item,
                                    variant: TextVariant.labelSmall,
                                    color: AppColors.kPrimaryColor,
                                  ),
                                  const SizedBox(width: 4),
                                  GestureDetector(
                                    onTap: () => toggleSelection(item),
                                    child: const Icon(
                                      Icons.close,
                                      size: 14,
                                      color: AppColors.kPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ),
            Icon(
              isDropdownOpen
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              color: AppColors.kSecondaryTextColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsList() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 200),
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.kSecondaryTextColor.withValues(alpha: 0.3),
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          final isSelected = selectedItems.contains(item);
          return ListTile(
            dense: true,
            title: CustomText(item, variant: TextVariant.labelMedium),
            trailing: Checkbox(
              value: isSelected,
              onChanged: (_) => toggleSelection(item),
              activeColor: AppColors.kPrimaryColor,
            ),
            onTap: () => toggleSelection(item),
          );
        },
      ),
    );
  }
}
