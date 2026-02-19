import '../../../../src_export.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({super.key});

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  int _quantity = 1;
  String _selectedMilk = AppStaticStrings.soyMilk;
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
            // backgroundColor: const Color(0xFFADA4F8),
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
                  // Choice of Milk Section
                  const SectionTitle(title: AppStaticStrings.choiceOfMilk),
                  _buildMilkSelectionList(context),

                  // space12H,

                  // Notes Section
                  const SectionTitle(title: AppStaticStrings.notes),
                  CustomTextField(
                    // controller: _notesController,
                    maxLines: 4,
                  ),
                  // space24H,
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: AppPadding.getPadding16(context),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12)),
        ),
        child: SafeArea(
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
                    // TODO: Logic for adding to cart
                    context.pushNamed(RoutesPath.cartPath);
                  },
                  backgroundColor: const Color(0xFFADA4F8),
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
    final milks = [
      AppStaticStrings.fullFatMilk,
      AppStaticStrings.lowFatMilk,
      AppStaticStrings.soyMilk,
      AppStaticStrings.coconutMilk,
      AppStaticStrings.almondMilk,
    ];

    return Column(
      children: milks.map((milk) {
        final isSelected = _selectedMilk == milk;
        return Column(
          // spacing: 12,
          children: [
            InkWell(
              onTap: () => setState(() => _selectedMilk = milk),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          milk,
                          fontSize: ResponsiveTextSizes.getFontSizeSmall(
                            context,
                          ),
                          fontWeight: FontWeight.w500,
                        ),
                        Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFADA4F8)
                                  : Colors.black26,
                              width: 1.5,
                            ),
                            color: isSelected
                                ? const Color(0xFFADA4F8)
                                : Colors.transparent,
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                  if (milk != milks.last)
                    const Divider(height: 1, color: Colors.black12),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
