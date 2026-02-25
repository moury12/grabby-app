import '../../../../src_export.dart';

class ShopHomePage extends StatelessWidget {
  const ShopHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12(context),
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ShopHomeHeader(),

              _buildStatsGrid(context),

              const ShopRecentOrdersHeader(),

              _buildOrdersList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        ShopStatCard(
          title: AppStaticStrings.todaysOrders,
          value: "24",
          iconContent: const Icon(
            Icons.shopping_bag_outlined,
            color: AppColors.kPrimaryColor,
          ),
          iconColor: AppColors.kPrimaryColor,
          bgColor: AppColors.kPrimaryColor.withValues(alpha: 0.1),
        ),
        ShopStatCard(
          title: AppStaticStrings.revenue,
          value: "AED 485",
          iconContent: const Icon(
            Icons.attach_money,
            color: AppColors.kGreenColor,
          ),
          iconColor: AppColors.kGreenColor,
          bgColor: AppColors.kGreenColor.withValues(alpha: 0.1),
        ),
        ShopStatCard(
          title: AppStaticStrings.activeItems,
          value: "24",
          iconPath: ImagesConstant.kMenuIcon,
          iconColor: Colors.orange,
          bgColor: Colors.orange.withValues(alpha: 0.1),
        ),
        ShopStatCard(
          title: AppStaticStrings.customers,
          value: "187",
          iconPath: ImagesConstant.kGroupIcon,
          iconColor: AppColors.kBlueColor,
          bgColor: AppColors.kBlueColor.withValues(alpha: 0.1),
        ),
      ],
    );
  }

  Widget _buildOrdersList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,

      itemBuilder: (context, index) {
        final List<Map<String, dynamic>> dummyOrders = [
          {
            "id": "#ORD-1234",
            "name": "John Doe",
            "items": "2 items",
            "status": AppStaticStrings.preparing,
            "price": "AED 12.50",
            "time": "2 min ago",
            "color": AppColors.kBlueColor,
          },
          {
            "id": "#ORD-1234",
            "name": "John Doe",
            "items": "2 items",
            "status": AppStaticStrings.pending,
            "price": "AED 12.50",
            "time": "2 min ago",
            "color": Colors.orange,
          },
          {
            "id": "#ORD-1234",
            "name": "John Doe",
            "items": "2 items",
            "status": AppStaticStrings.ready,
            "price": "AED 12.50",
            "time": "2 min ago",
            "color": AppColors.kGreenColor,
          },
        ];

        final order = dummyOrders[index];

        return ShopOrderItemWidget(
          id: order["id"],
          name: order["name"],
          items: order["items"],
          status: order["status"],
          price: order["price"],
          time: order["time"],
          statusColor: order["color"],
        );
      },
    );
  }
}
