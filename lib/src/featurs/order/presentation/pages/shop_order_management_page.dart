import '../../../../src_export.dart';
import '../widgets/shop_order_card.dart';
import '../../../profile-settings/presentation/bloc/branch/branch_bloc.dart';

class ShopOrderManagementPage extends StatefulWidget {
  const ShopOrderManagementPage({super.key});

  @override
  State<ShopOrderManagementPage> createState() =>
      _ShopOrderManagementPageState();
}

class _ShopOrderManagementPageState extends State<ShopOrderManagementPage> {
  String? selectedBranchId;
  String? selectedBranchName;
  int selectedTabIndex = 0;

  final List<String> tabs = [
    'all',
    'placed',
    'preparing',
    'ready',
    'completed',
    'cancelled',
  ];

  @override
  void initState() {
    super.initState();
    context.read<BranchBloc>().add(GetBranchesEvent());
  }

  void _fetchOrders() {
    if (selectedBranchId != null) {
      context.read<OrderBloc>().add(
        FetchBranchOrdersEvent(
          branchId: selectedBranchId!,
          status: tabs[selectedTabIndex],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(
              AppStaticStrings.orderManagement,
              variant: TextVariant.headlineSmall,
            ),
            BranchDropdown(
              initialBranchId: selectedBranchId,
              onBranchSelected: (id, name) {
                setState(() {
                  selectedBranchId = id;
                  selectedBranchName = name;
                });
                _fetchOrders();
              },
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(tabs.length * 2 - 1, (index) {
                    if (index.isOdd) {
                      return Container(
                        width: 1,
                        height: 24,
                        color: Colors.white.withValues(alpha: 0.5),
                      );
                    }
                    final tabIndex = index ~/ 2;
                    final isSelected = selectedTabIndex == tabIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() => selectedTabIndex = tabIndex);
                        _fetchOrders();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        height: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.kSecondaryColor
                              : Colors.transparent,
                          borderRadius: isSelected
                              ? BorderRadius.circular(8)
                              : null,
                        ),
                        child: CustomText(
                          tabs[tabIndex].toUpperCase(),
                          variant: TextVariant.labelSmall,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (selectedBranchId == null) {
            return const Center(child: CustomText("Please select a branch"));
          }
          if (state.status == OrderStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == OrderStatus.failure) {
            return Center(child: CustomText(state.errorMessage ?? "Error"));
          }
          if (state.orders.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async => _fetchOrders(),
              child: Stack(
                children: [
                  ListView(),
                  const Center(child: CustomText("No orders found")),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => _fetchOrders(),
            child: ListView.builder(
              padding: AppPadding.getPadding12H(context),
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                final order = state.orders[index];
                return ShopOrderCard(
                  order: order,
                  onTap: () async {
                    final result = await context.pushNamed(
                      RoutesPath.shopOrderDetailsPath,
                      extra: order,
                    );
                    if (result == true) {
                      _fetchOrders();
                    }
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
