import 'dart:io';
import '../../../../src_export.dart';

class EditDiscountBottomSheet extends StatefulWidget {
  final String? title;
  final PromotionModel? promotion; // For edit mode
  const EditDiscountBottomSheet({super.key, this.title, this.promotion});

  @override
  State<EditDiscountBottomSheet> createState() =>
      _EditDiscountBottomSheetState();
}

class _EditDiscountBottomSheetState extends State<EditDiscountBottomSheet> {
  final Set<String> selectedItems = {};
  bool isDropdownOpen = false;
  File? _pickedImage;

  // Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _occasionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize form with existing promotion data if editing
    if (widget.promotion != null) {
      _nameController.text = widget.promotion!.discountName;
      _occasionController.text = widget.promotion!.eventName ?? '';
      _startDateController.text = widget.promotion!.startDate.toString().split('T')[0];
      _endDateController.text = widget.promotion!.endDate.toString().split('T')[0];
      _discountController.text = widget.promotion!.discountValue.toString();
      selectedItems.addAll(widget.promotion!.specificItems.map((item) => item.itemName));
    }

    // Load menu items if not already loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final menuState = context.read<MenuBloc>().state;
      if (menuState.items.isEmpty && menuState.status != MenuStatus.loading) {
        context.read<MenuBloc>().add(GetMenuItemsEvent());
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _occasionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  void toggleSelection(String item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    });
  }

  void _submitForm() {
    if (_nameController.text.isEmpty ||
        _startDateController.text.isEmpty ||
        _endDateController.text.isEmpty ||
        _discountController.text.isEmpty ||
        selectedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final data = {
      'name': _nameController.text,
      'eventOccasion': _occasionController.text.isNotEmpty ? _occasionController.text : null,
      'startDate': _startDateController.text,
      'endDate': _endDateController.text,
      'discountPercentage': int.parse(_discountController.text),
      'specificItems': selectedItems.map((item) => {'name': item}).toList(),
      if (_pickedImage != null) 'image': _pickedImage!.path,
    };

    final bloc = context.read<PromotionBloc>();
    if (widget.promotion != null) {
      // Edit mode
      bloc.add(UpdatePromotionEvent(widget.promotion!.id, data));
    } else {
      // Create mode
      bloc.add(CreatePromotionEvent(data));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PromotionBloc, PromotionState>(
      listener: (context, state) {
        if (state is PromotionOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          context.pop();
        } else if (state is PromotionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Container(
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
            CustomTextField(textEditingController: _nameController, hintText: "Cappuccino"),

            _buildFieldLabel(AppStaticStrings.eventOccasionOptional),
            CustomTextField(textEditingController: _occasionController, hintText: ""),

            Row(
              spacing: 6,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFieldLabel(AppStaticStrings.startDate),
                      CustomTextField(textEditingController: _startDateController, hintText: ""),
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFieldLabel(AppStaticStrings.endDate),
                      CustomTextField(textEditingController: _endDateController, hintText: ""),
                    ],
                  ),
                ),
              ],
            ),

            _buildFieldLabel(AppStaticStrings.appliedToItem),
            _buildMultiSelectField(),
            if (isDropdownOpen) _buildItemsList(),
            _buildFieldLabel(AppStaticStrings.discountPercentage),
            CustomTextField(textEditingController: _discountController, hintText: ""),

            CustomButton(
              text: widget.title != null
                  ? AppStaticStrings.addPromotion
                  : AppStaticStrings.saveChanges,
              onPressed: _submitForm,
            ),

            CustomButton(
              text: AppStaticStrings.cancel,
              onPressed: () => context.pop(),
              isOutlined: true,
            ),
            const SizedBox(height: 10),
          ],
        ),
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
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, menuState) {
        final menuItems = menuState.items;
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
              final isSelected = selectedItems.contains(item.itemName);
              return ListTile(
                dense: true,
                title: CustomText(item.itemName, variant: TextVariant.labelMedium),
                trailing: Checkbox(
                  value: isSelected,
                  onChanged: (_) => toggleSelection(item.itemName),
                  activeColor: AppColors.kPrimaryColor,
                ),
                onTap: () => toggleSelection(item.itemName),
              );
            },
          ),
        );
      },
    );
  }
}
