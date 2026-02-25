import '../../../../src_export.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isCarPickup = true;

  final List<Map<String, dynamic>> _cartItems = [
    {
      'title': AppStaticStrings.icedMatchaLatte,
      'description': 'Honey, Full Fat, Chocolate Muffin, Medium',
      'price': 16.60,
      'quantity': 1,
      'imageUrl': null,
    },
  ];

  double get _subtotal => _cartItems.fold(
    0.0,
    (sum, item) => sum + (item['price'] as double) * (item['quantity'] as int),
  );

  double get _total => _subtotal;

  void _incrementQuantity(int index) {
    setState(() {
      _cartItems[index]['quantity'] =
          (_cartItems[index]['quantity'] as int) + 1;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      final current = _cartItems[index]['quantity'] as int;
      if (current > 1) {
        _cartItems[index]['quantity'] = current - 1;
      }
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        title: const Text(AppStaticStrings.cart),
        backgroundColor: AppColors.kBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context).copyWith(top: 0),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cart Items
            ..._cartItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => _deleteItem(index),
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(Icons.delete_rounded, color: Colors.white),
                ),
                child: CartItemWithStepperCard(
                  title: item['title'] as String,
                  description: item['description'] as String,
                  quantity: item['quantity'] as int,
                  price: (item['price'] as double) * (item['quantity'] as int),
                  imageUrl: item['imageUrl'] as String?,
                  onIncrement: () => _incrementQuantity(index),
                  onDecrement: () => _decrementQuantity(index),
                  onDelete: () => _deleteItem(index),
                ),
              );
            }),

            // Pickup Type Section
            PickupSelectionWidget(
              isCarPickup: _isCarPickup,
              onSelectionChanged: (value) {
                setState(() => _isCarPickup = value);
              },
            ),

            // Car Plate row (only visible when Car Pickup selected)
            if (_isCarPickup)
              CarPlateNumberWidget(plateNumber: 'A 24202', onTap: () {}),

            // Grabby Credit (Rewards)
            GrabbyCreditWidget(
              availableAmount: 0.66,
              availablePoints: 66,
              onApplyCredit: () {},
            ),

            // Promo Code
            PromoCodeWidget(onApply: () {}),

            // Order Summary
            CartOrderSummaryWidget(subtotal: _subtotal, total: _total),

            const SizedBox(height: 8),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
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
