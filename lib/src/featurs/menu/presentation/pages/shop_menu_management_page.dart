import '../../../../src_export.dart';

class ShopMenuManagementPage extends StatefulWidget {
  const ShopMenuManagementPage({super.key});

  @override
  State<ShopMenuManagementPage> createState() => _ShopMenuManagementPageState();
}

class _ShopMenuManagementPageState extends State<ShopMenuManagementPage> {
  String _selectedCategory = AppStaticStrings.allItems;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    AppStaticStrings.allItems,
    AppStaticStrings.matcha,
    AppStaticStrings.hotCoffee,
    AppStaticStrings.coldCoffee,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const CustomText(
          AppStaticStrings.menuManagement,
          variant: TextVariant.titleLarge,
        ),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              context.pushNamed(RoutesPath.editItemName);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.circular(appRadius),
              ),
              child: Row(
                children: [
                  Icon(Icons.add, color: Colors.white, size: 15),
                  CustomText(AppStaticStrings.addItem, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            CustomTextField(
              textEditingController: _searchController,
              hintText: AppStaticStrings.searchMenuItems,
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.kSecondaryTextColor,
              ),
              fillColor: Colors.white,
              borderRadius: 16,
            ),

            // Category Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 12,
                children: _categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return ButtonTapWidget(
                    onTap: () => setState(() => _selectedCategory = category),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.kPrimaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomText(
                        category,
                        color: isSelected
                            ? Colors.white
                            : AppColors.kSecondaryTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Summary Stats
            Row(
              spacing: 12,
              children: [
                _buildStatText(AppStaticStrings.totalItems, "7"),
                _buildStatText(
                  AppStaticStrings.available,
                  "6",
                  valueColor: AppColors.kPrimaryColor,
                ),
                _buildStatText(
                  AppStaticStrings.outOfStock,
                  "1",
                  valueColor: Colors.red,
                ),
              ],
            ),

            // Items List
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                return MenuManagementItemCard(
                  title: "Cappuccino",
                  description: "Classic Italian coffee with steamed milk",
                  price: "5.50AED",
                  image: index == 0
                      ? "https://images.unsplash.com/photo-1541167760496-162955ed8a9f?q=80&w=2033&auto=format&fit=crop"
                      : "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?q=80&w=2070&auto=format&fit=crop",
                  category: "Coffee",
                  isAvailable: index != 2,
                  outOfStockCount: index == 2 ? "50" : null,
                  isVisible: index != 0,
                  onEdit: () => context.pushNamed(RoutesPath.editItemName),
                  onDelete: () {},
                  onToggleVisibility: () {},
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatText(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          label,
          fontSize: 14,
          color: AppColors.kSecondaryTextColor,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(width: 4),
        CustomText(
          value,
          fontSize: 14,
          color: valueColor ?? AppColors.kSecondaryTextColor,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
