import '../../../../src_export.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isCarPickup = true;

  final List<Map<String, String>> _cartItems = [
    {
      "quantity": "1x",
      "title": AppStaticStrings.icedMatchaLatte,
      "description": "Honey, Full Fat, Chocolate Muffin, Medium",
      "price": "16.60",
    },
    {
      "quantity": "1x",
      "title": AppStaticStrings.icedMatchaLatte,
      "description": "Honey, Full Fat, Chocolate Muffin, Medium",
      "price": "16.60",
    },
  ];

  double get _totalPrice =>
      _cartItems.fold(0.0, (sum, item) => sum + double.parse(item["price"]!));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStaticStrings.cart)),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cart Items
            ..._cartItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  setState(() {
                    _cartItems.removeAt(index);
                  });
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: CartItemCard(
                  quantity: item["quantity"]!,
                  title: item["title"]!,
                  description: item["description"]!,
                  price: "AED ${item["price"]}",
                ),
              );
            }),

            // Pickup Selection
            PickupSelectionWidget(
              isCarPickup: _isCarPickup,
              onSelectionChanged: (value) {
                setState(() {
                  _isCarPickup = value;
                });
              },
            ),

            // Car Plate Number (only if car pickup selected)
            if (_isCarPickup)
              CarPlateNumberWidget(plateNumber: "ABC 1234", onTap: () {}),

            // Loyalty Reward
            const LoyaltyRewardWidget(
              label: AppStaticStrings.freeDrinkLoyaltyReward,
              reward: AppStaticStrings.free,
            ),

            // Order Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  AppStaticStrings.orderTotal,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  "${_totalPrice.toStringAsFixed(2)} AED",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: AppPadding.getPadding16(context).copyWith(bottom: 24),
        child: CustomButton(
          text: AppStaticStrings.proceedToCheckout,
          onPressed: () {
            context.pushNamed(RoutesPath.checkoutPath);
          },
        ),
      ),
    );
  }
}
