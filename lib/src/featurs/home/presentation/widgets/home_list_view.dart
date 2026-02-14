import '../../../../src_export.dart';

class HomeListView extends StatelessWidget {
  const HomeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: AppPadding.getPadding12(context).copyWith(top: 0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return const CafeCardWidget(
            title: "Brew & Co.............",
            image:
                "https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?q=80&w=2078&auto=format&fit=crop",
            distance: "0.3 km",
            openHours: "7:00 AM - 9:00 PM",
          );
        }, childCount: 5),
      ),
    );
  }
}
