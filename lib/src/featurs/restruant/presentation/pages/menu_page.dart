import '../../../../src_export.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String _selectedCategory = AppStaticStrings.allItems;

  final List<String> _categories = [
    AppStaticStrings.allItems,
    AppStaticStrings.matcha,
    AppStaticStrings.hotCoffee,
    AppStaticStrings.coldCoffee,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(AppStaticStrings.menu),
        actions: [
          ButtonTapWidget(
            onTap: () {
              context.pushNamed(RoutesPath.cartPath);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SvgPicture.asset(
                ImagesConstant.kCartIcon,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context).copyWith(top: 0),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Header
            Stack(
              children: [
                const CustomNetworkImage(
                  imageUrl:
                      "https://images.unsplash.com/photo-1541167760496-162955ed8a9f?q=80&w=2033&auto=format&fit=crop",
                  height: 180,
                  width: double.infinity,
                  radius: 16,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.6),
                          Colors.transparent,
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          AppStaticStrings.hotCoffee,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.kPrimaryColor.withValues(
                              alpha: 0.8,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const CustomText(
                            AppStaticStrings.tryItNow,
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Loyalty Stamps
            const LoyaltyStampsWidget(currentStamps: 4),

            // Category Chips
            Container(
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: AppPadding.getPadding4(context),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 8,
                  children: _categories.map((category) {
                    return _buildCategoryChip(
                      category,
                      _selectedCategory == category,
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
            ),

            // Menu Sections
            if (_selectedCategory == AppStaticStrings.allItems ||
                _selectedCategory == AppStaticStrings.matcha)
              _buildMenuSection(AppStaticStrings.matcha, [
                MenuItemWidget(
                  title: AppStaticStrings.caffeLatte,
                  price: AppStaticStrings.price,
                  image:
                      "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?q=80&w=2070&auto=format&fit=crop",
                  discount: AppStaticStrings.discount,
                  onAdd: () {},
                ),
                MenuItemWidget(
                  title: AppStaticStrings.caffeLatte,
                  price: AppStaticStrings.price,
                  image:
                      "https://images.unsplash.com/photo-1541167760496-162955ed8a9f?q=80&w=2033&auto=format&fit=crop",
                  onAdd: () {},
                ),
              ]),

            if (_selectedCategory == AppStaticStrings.allItems ||
                _selectedCategory == AppStaticStrings.hotCoffee)
              _buildMenuSection(AppStaticStrings.hotCoffee, [
                MenuItemWidget(
                  title: AppStaticStrings.caffeLatte,
                  price: AppStaticStrings.price,
                  image:
                      "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?q=80&w=2070&auto=format&fit=crop",
                  onAdd: () {},
                ),
                MenuItemWidget(
                  title: AppStaticStrings.caffeLatte,
                  price: AppStaticStrings.price,
                  image:
                      "https://images.unsplash.com/photo-1541167760496-162955ed8a9f?q=80&w=2033&auto=format&fit=crop",
                  onAdd: () {},
                ),
              ]),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(
    String label,
    bool isSelected, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.kSecondaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: CustomText(
          label,
          variant: TextVariant.titleMedium,
          color: AppColors.kWhiteTextColor,
        ),
      ),
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(title, fontSize: 18, fontWeight: FontWeight.bold),
        ...items,
        const Divider(height: 2),
      ],
    );
  }
}
