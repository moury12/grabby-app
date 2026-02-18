import '../../../../src_export.dart';

class OrderTrackingMapViewPage extends StatelessWidget {
  const OrderTrackingMapViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStaticStrings.orderTracking)),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          spacing: 16,
          children: [const CustomText("Order details implementation...")],
        ),
      ),
    );
  }
}
