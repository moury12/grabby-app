import '../../../../src_export.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isCarPickup = true;
  late String branchId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    branchId = GoRouterState.of(context).extra as String? ?? '';
    if (branchId.isNotEmpty) {
      context.read<CartBloc>().add(FetchCartEvent(branchId));
    }
  }

  void _incrementQuantity(CartItemModel item) {
    if (item.id != null) {
      context.read<CartBloc>().add(UpdateCartItemEvent(item.id!, item.quantity + 1, branchId));
    }
  }

  void _decrementQuantity(CartItemModel item) {
    if (item.id != null && item.quantity > 1) {
      context.read<CartBloc>().add(UpdateCartItemEvent(item.id!, item.quantity - 1, branchId));
    }
  }

  void _deleteItem(CartItemModel item) {
    if (item.id != null) {
      context.read<CartBloc>().add(DeleteCartItemEvent(item.id!, branchId));
    }
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
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.status == CartStatus.loading && state.cart == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == CartStatus.error && state.cart == null) {
            return Center(child: CustomText(state.errorMessage ?? 'Error loading cart'));
          }
          final cart = state.cart;
          if (cart == null || cart.items.isEmpty) {
            return const Center(child: CustomText('Your cart is empty'));
          }

          return SingleChildScrollView(
            padding: AppPadding.getPadding12(context).copyWith(top: 0),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cart Items
                ...cart.items.map((item) {
                  return Dismissible(
                    key: Key(item.id ?? UniqueKey().toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) => _deleteItem(item),
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
                      title: item.menuName,
                      description: item.additionalItems.map((e) => e.name).join(', '),
                      quantity: item.quantity,
                      price: item.totalPrice ?? 0,
                      imageUrl: item.menuImage,
                      onIncrement: () => _incrementQuantity(item),
                      onDecrement: () => _decrementQuantity(item),
                      onDelete: () => _deleteItem(item),
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
                CartOrderSummaryWidget(
                  subtotal: cart.totalAmount,
                  total: cart.totalAmount,
                ),

                const SizedBox(height: 8),
              ],
            ),
          );
        },
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
