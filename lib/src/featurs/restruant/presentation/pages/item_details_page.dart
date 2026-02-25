import '../../../../src_export.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({super.key});

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  int _quantity = 1;
  String _selectedMilk = 'Regular Milk';
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Collapsible Header Image
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            automaticallyImplyLeading: false,
            leadingWidth: 70,
            leading: Center(
              child: ButtonTapWidget(
                onTap: () => context.pop(),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFADA4F8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
            flexibleSpace: const FlexibleSpaceBar(
              background: CustomNetworkImage(
                imageUrl:
                    "https://images.unsplash.com/photo-1541167760496-162955ed8a9f?q=80&w=2033&auto=format&fit=crop",
                height: 300,
                width: double.infinity,
                radius: 0,
              ),
            ),
          ),

          // Content
          SliverPadding(
            padding: AppPadding.getPadding12(context),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  CustomText(
                    "Item name here",
                    variant: TextVariant.headlineMedium,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    "AED 16.00",
                    variant: TextVariant.labelLarge,
                    color: AppColors.kPrimaryColor,
                  ),
                  // Choice of Milk Section
                  Container(
                    width: double.infinity,
                    padding: AppPadding.getPadding12(context),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(appRadius),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle(
                          title: AppStaticStrings.choiceOfMilk,
                        ),
                        const SizedBox(height: 8),
                        _buildMilkSelectionList(context),
                      ],
                    ),
                  ),

                  // Notes Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      const SectionTitle(title: AppStaticStrings.notes),
                      CustomTextField(hintText: "Add notes...", maxLines: 4),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: AppPadding.getPadding12H(context),
          child: Row(
            spacing: 16,
            children: [
              // Quantity Selector
              QuantitySelector(
                quantity: _quantity,
                onIncrement: () => setState(() => _quantity++),
                onDecrement: () {
                  if (_quantity > 1) setState(() => _quantity--);
                },
              ),

              // Add to Bag Button
              Expanded(
                child: CustomButton(
                  text:
                      "Add $_quantity to bag. AED${(16.00 * _quantity).toStringAsFixed(2)}",
                  onPressed: () {
                    context.pushNamed(RoutesPath.cartPath);
                  },
                  backgroundColor: AppColors.kPrimaryColor,
                  borderRadius: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMilkSelectionList(BuildContext context) {
    // Defining milks with their optional extra price
    final List<Map<String, dynamic>> milks = [
      {'name': 'Regular Milk', 'price': null},
      {'name': 'Oat Milk', 'price': '+AED 5.00'},
      {'name': 'Almond Milk', 'price': '+AED 5.00'},
      {'name': 'Coconut Milk', 'price': '+AED 5.00'},
    ];

    return Column(
      children: milks.map((milk) {
        final isSelected = _selectedMilk == milk['name'];
        return InkWell(
          onTap: () => setState(() => _selectedMilk = milk['name']),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                // Radio Button Icon
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.kPrimaryColor : Colors.grey,
                      width: 1.5,
                    ),
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              color: AppColors.kPrimaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                // Milk name
                Expanded(
                  child: CustomText(
                    milk['name'],
                    fontSize: 14,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                // Price if any
                if (milk['price'] != null)
                  CustomText(
                    milk['price'],
                    fontSize: 12,
                    color: AppColors.kSecondaryTextColor,
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
