import '../../../../src_export.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isCarPickup = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: const CustomText(
          AppStaticStrings.cart,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding16(context),
        child: Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cart Items
            const CartItemCard(
              quantity: "1x",
              title: AppStaticStrings.icedMatchaLatte,
              description: "Honey, Full Fat, Chocolate Muffin, Medium",
              price: "AED 16.60",
            ),

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
                const CustomText(
                  "16.60 AED",
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
          onPressed: () {},
        ),
      ),
    );
  }
}
