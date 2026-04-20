import '../../../../src_export.dart';

class MenuPage extends StatefulWidget {
  final CustomerBranchModel branch;
  const MenuPage({super.key, required this.branch});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  String _selectedCategory = AppStaticStrings.allItems;

  late List<String> _categories;

  @override
  void initState() {
    super.initState();
    _categories = [
      AppStaticStrings.allItems,
      ...(widget.branch.menuCategories?.map((e) => e.name).toList() ?? []),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final menuCategories = widget.branch.menuCategories ?? [];

    return Scaffold(
      appBar: AppBar(
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
            // Stack(
            //   children: [
            //     CustomNetworkImage(
            //       imageUrl: widget.branch.image != null
            //           ? "${ApiEndpoints.baseUrl}${widget.branch.image}"
            //           : "https://images.unsplash.com/photo-1541167760496-162955ed8a9f?q=80&w=2033&auto=format&fit=crop",
            //       height: 180,
            //       width: double.infinity,
            //       radius: 16,
            //     ),
            //     Positioned(
            //       bottom: 0,
            //       left: 0,
            //       right: 0,
            //       child: Container(
            //         padding: const EdgeInsets.symmetric(
            //           horizontal: 16,
            //           vertical: 12,
            //         ),
            //         decoration: BoxDecoration(
            //           gradient: LinearGradient(
            //             begin: Alignment.bottomCenter,
            //             end: Alignment.topCenter,
            //             colors: [
            //               Colors.black.withValues(alpha: 0.6),
            //               Colors.transparent,
            //             ],
            //           ),
            //           borderRadius: const BorderRadius.only(
            //             bottomLeft: Radius.circular(16),
            //             bottomRight: Radius.circular(16),
            //           ),
            //         ),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             CustomText(
            //               widget.branch.branchName,
            //               fontSize: 18,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.white,
            //             ),
            //             Container(
            //               padding: const EdgeInsets.symmetric(
            //                 horizontal: 12,
            //                 vertical: 6,
            //               ),
            //               decoration: BoxDecoration(
            //                 color: AppColors.kPrimaryColor.withValues(
            //                   alpha: 0.8,
            //                 ),
            //                 borderRadius: BorderRadius.circular(20),
            //               ),
            //               child: const CustomText(
            //                 AppStaticStrings.tryItNow,
            //                 fontSize: 12,
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            // // Loyalty Stamps (Placeholder current stamps)
            // const LoyaltyStampsWidget(currentStamps: 0),

            // Category Chips
            SingleChildScrollView(
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

            // Menu Sections
            ...menuCategories
                .where((cat) =>
                    _selectedCategory == AppStaticStrings.allItems ||
                    _selectedCategory == cat.name)
                .map((cat) => _buildMenuSection(
                      cat.name,
                      cat.menus
                          .map((item) => MenuItemWidget(
                                title: item.itemName,
                                price: "\$${item.price.toStringAsFixed(1)}",
                                image: item.image != null &&
                                        item.image!.isNotEmpty
                                    ? "${ApiEndpoints.baseUrl}${item.image}"
                                    : "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?q=80&w=2070&auto=format&fit=crop",
                                // discount: "", // Could be derived if needed
                                onAdd: () {
                                   context.pushNamed(RoutesPath.itemDetailsPath,extra: item);
                                  // Implementation for adding to cart
                                },
                              ))
                          .toList(),
                    )),
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
          color: isSelected ? AppColors.kPrimaryColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          spacing: 6,
          children: [
            if (label == AppStaticStrings.hotCoffee)
              Image.asset("assets/icons/stamp_category_icon.png", height: 15),
            CustomText(
              label,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? AppColors.kWhiteTextColor
                  : AppColors.kPrimaryColor,
            ),
          ],
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
