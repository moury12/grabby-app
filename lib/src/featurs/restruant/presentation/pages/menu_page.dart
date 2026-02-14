import '../../../../src_export.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        centerTitle: true,
        title: Text(AppStaticStrings.menu),
        actions: [
          Padding(
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
                        CustomText(
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
                          child: CustomText(
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
                  children: [
                    _buildCategoryChip(AppStaticStrings.allItems, true),
                    _buildCategoryChip(AppStaticStrings.matcha, false),
                    _buildCategoryChip(AppStaticStrings.hotCoffee, false),
                    _buildCategoryChip(AppStaticStrings.coldCoffee, false),
                  ],
                ),
              ),
            ),

            // Menu Sections
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

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
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
