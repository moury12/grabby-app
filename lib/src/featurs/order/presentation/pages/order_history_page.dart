import '../../../../src_export.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FE),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                floating: true,
                pinned: true,
                snap: true,
                title: const CustomText(
                  AppStaticStrings.orders,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                centerTitle: false,
                bottom: TabBar(
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  indicatorColor: AppColors.kPrimaryColor,
                  labelColor: AppColors.kPrimaryColor,
                  unselectedLabelColor: AppColors.kSecondaryTextColor,
                  dividerColor: Colors.transparent,
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: -20),
                  tabs: [
                    _buildTab("All"),
                    _buildTab("Active"),
                    _buildTab("Completed"),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              _buildOrderList(context, "all"),
              _buildOrderList(context, "active"),
              _buildOrderList(context, "completed"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String label) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Text(label),
      ),
    );
  }

  Widget _buildOrderList(BuildContext context, String filter) {
    return ListView.separated(
      padding: AppPadding.getPadding12(context),
      itemCount: 3,
      separatorBuilder: (context, index) => space16H,
      itemBuilder: (context, index) {
        return OrderCard(
          shopName: "Brew & Co",
          orderId: "#GC12345",
          items: const ["2x Caffe Latte", "1x Croissant"],
          dateTime: "Today, 10:30 AM",
          price: "\$11.60",
          status: filter == "active" ? "Ready for Pickup" : "Completed",
          isActive: filter == "active",
        );
      },
    );
  }
}
