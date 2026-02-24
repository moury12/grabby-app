import '../../../../src_export.dart';

class EditItemPage extends StatefulWidget {
  final Map<String, dynamic>? item;

  const EditItemPage({super.key, this.item});

  @override
  State<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  bool giveStamp = true;
  bool availableNow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const CustomText(
          AppStaticStrings.editItem,
          variant: TextVariant.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context).copyWith(top: 0),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageUpload(),
            _buildTextField(
              AppStaticStrings.itemName,
              AppStaticStrings.enterItemName,
            ),
            _buildCategorySelection(),
            _buildTextField(AppStaticStrings.priceAED, "5.5"),
            _buildTextField(
              AppStaticStrings.description,
              AppStaticStrings.describeYourItem,
              maxLines: 3,
            ),
            _buildAddCustomizationButton(),
            _buildCustomizationGroups(),
            _buildLoyaltySection(),
            _buildAvailableNowSection(),
            // const SizedBox(height: 16),
            _buildActionButtons(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildImageUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        const CustomText(AppStaticStrings.image, fontWeight: FontWeight.bold),
        Container(
          padding: AppPadding.getPadding8(context),
          width: double.infinity,
          // height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              const Icon(
                Icons.file_upload_outlined,
                color: AppColors.kPrimaryColor,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.4,
                child: CustomButton(
                  text: AppStaticStrings.uploadImage,
                  onPressed: () {},
                  backgroundColor: AppColors.kPrimaryColor.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String title, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        CustomText(title, fontWeight: FontWeight.bold),
        CustomTextField(
          hintText: hint,
          maxLines: maxLines,
          fillColor: Colors.white,
          borderRadius: 12,
        ),
      ],
    );
  }

  Widget _buildCategorySelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        const CustomText(
          AppStaticStrings.category,
          fontWeight: FontWeight.bold,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: "Option 1",
              items: ["Option 1", "Matcha", "Coffee"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (_) {},
            ),
          ),
        ),
        ButtonTapWidget(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => const CategoriesManagementBottomSheet(),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xffE8F5E9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const CustomText(
              AppStaticStrings.editCategory,
              color: Colors.green,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddCustomizationButton() {
    return ButtonTapWidget(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => const AddCustomizeGroupBottomSheet(),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.kPrimaryColor.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: CustomText(
            AppStaticStrings.addCustomization,
            color: AppColors.kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCustomizationGroups() {
    return Column(
      spacing: 12,
      children: [
        _buildCustomizationGroup("Choice Of Milk", [
          {"name": "Oat Milk", "price": "+0 AED"},
          {"name": "Full Fat Milk", "price": "+0 AED"},
          {"name": "Skimmed Milk", "price": "+0 AED"},
        ]),
        _buildCustomizationGroup("Sugar", [
          {"name": "Less Sugar", "price": "+0 AED"},
          {"name": "Normal Sugar", "price": "+0 AED"},
          {"name": "Extra Sugar", "price": "+0 AED"},
        ]),
      ],
    );
  }

  Widget _buildCustomizationGroup(
    String title,
    List<Map<String, String>> items,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(title, fontWeight: FontWeight.bold),
                const CustomText(
                  AppStaticStrings.deleteGroup,
                  color: Colors.red,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.menu, size: 20, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(child: CustomText(item["name"]!)),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffEEECFF),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: CustomText(
                      item["price"]! == "+0 AED" ? "Free" : item["price"]!,
                      fontSize: 10,
                      color: AppColors.kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.delete_outline, size: 20, color: Colors.red),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoyaltySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        const CustomText(AppStaticStrings.loyalty, fontWeight: FontWeight.bold),
        Container(
          // padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Checkbox(
                value: giveStamp,
                onChanged: (val) => setState(() => giveStamp = val ?? false),
                activeColor: AppColors.kPrimaryColor,
              ),
              const Expanded(
                child: CustomText(
                  AppStaticStrings.giveStampForItem,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvailableNowSection() {
    return Container(
      padding: AppPadding.getPadding8(context).copyWith(top: 0, right: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(appRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                AppStaticStrings.availableNow,
                variant: TextVariant.labelSmall,
                fontWeight: FontWeight.bold,
              ),
              Switch(
                value: availableNow,
                onChanged: (val) => setState(() => availableNow = val),
                activeTrackColor: AppColors.kPrimaryColor,
                activeThumbColor: Colors.white,
              ),
            ],
          ),
          const CustomText(
            AppStaticStrings.makeItemAvailable,
            variant: TextVariant.labelSmall,
            color: AppColors.kSecondaryTextColor,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      // spacing: 12,
      children: [
        CustomButton(
          text: AppStaticStrings.saveChanges,
          onPressed: () => context.pop(),
          backgroundColor: AppColors.kPrimaryColor,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => context.pop(),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: const BorderSide(color: Colors.grey),
            ),
            child: const CustomText(
              AppStaticStrings.cancel,
              color: AppColors.kSecondaryTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
