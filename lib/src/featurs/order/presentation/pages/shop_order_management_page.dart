import '../../../../src_export.dart';

class ShopOrderManagementPage extends StatefulWidget {
  const ShopOrderManagementPage({super.key});

  @override
  State<ShopOrderManagementPage> createState() =>
      _ShopOrderManagementPageState();
}

class _ShopOrderManagementPageState extends State<ShopOrderManagementPage> {
  String selectedBranch = "Brew&Blow";
  final List<String> branches = ["Brew&Blow", "Downtown", "Uptown"];
  int selectedTabIndex = 0;

  final List<String> tabs = [
    AppStaticStrings.all,
    AppStaticStrings.pending,
    AppStaticStrings.preparing,
    AppStaticStrings.ready,
    AppStaticStrings.completed,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              AppStaticStrings.orderManagement,
              variant: TextVariant.headlineSmall,
              // fontWeight: FontWeight.bold,
            ),
            _buildBranchDropdown(),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Padding(
            padding: AppPadding.getPadding10(context),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
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
                    onTap: () => setState(() => selectedTabIndex = tabIndex),
                    child: Container(
                      padding: AppPadding.getPadding6H(context),
                      height: double.infinity,

                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors
                                  .kSecondaryColor // Light blue highlight
                            : Colors.transparent,
                        borderRadius: isSelected
                            ? BorderRadius.circular(8)
                            : null,
                      ),
                      child: CustomText(
                        tabs[tabIndex],
                        variant: TextVariant.labelMedium,
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
      body: _buildOrderList(tabs[selectedTabIndex]),
    );
  }

  Widget _buildBranchDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: SizedBox(
          height: 30,
          child: DropdownButton<String>(
            value: selectedBranch,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.kPrimaryColor,
            ),
            style: TextStyle(
              color: AppColors.kPrimaryColor,
              fontSize: ResponsiveTextSizes.getFontSizeSmall(context),
              fontWeight: FontWeight.w800,
            ),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() => selectedBranch = newValue);
              }
            },
            items: branches.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: CustomText(
                  value,
                  variant: TextVariant.labelSmall,
                  color: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.w700,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderList(String filter) {
    // Dummy Data
    final List<Map<String, dynamic>> dummyOrders = [
      {
        "id": "#ORD-1234",
        "time": "2 min ago",
        "customer": "John Doe",
        "orderCount": 12,
        "stampCount": 6,
        "items": [
          {"qty": 2, "name": "Cappuccino", "price": "5.50"},
          {"qty": 1, "name": "Croissant", "price": "5.50"},
        ],
        "status": AppStaticStrings.pending,
        "pickup": AppStaticStrings.pickupCounter,
        "total": "14.50",
      },
      {
        "id": "#ORD-1235",
        "time": "5 min ago",
        "customer": "Jane Smith",
        "orderCount": 5,
        "stampCount": 2,
        "items": [
          {"qty": 1, "name": "Latte", "price": "14.50"},
        ],
        "status": AppStaticStrings.preparing,
        "pickup": "${AppStaticStrings.carPickupWithPlate}ABC 123",
        "total": "14.50",
      },
    ];

    final filteredOrders = filter == AppStaticStrings.all
        ? dummyOrders
        : dummyOrders.where((o) => o['status'] == filter).toList();

    return ListView.builder(
      padding: AppPadding.getPadding12H(context),
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        return ShopOrderCard(
          orderId: order['id'],
          time: order['time'],
          customerName: order['customer'],
          orderCount: order['orderCount'],
          stampCount: order['stampCount'],
          items: List<Map<String, dynamic>>.from(order['items']),
          status: order['status'],
          pickupType: order['pickup'],
          totalPrice: order['total'],
          onTap: () {
            context.pushNamed(RoutesPath.shopOrderDetailsPath);
          },
        );
      },
    );
  }
}
