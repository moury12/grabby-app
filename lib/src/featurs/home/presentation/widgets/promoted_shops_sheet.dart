import '../../../../src_export.dart';

class PromotedShopsSheet extends StatelessWidget {
  const PromotedShopsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding12(context),
      decoration: const BoxDecoration(
        color: AppColors.kBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: .3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          CustomText(
            AppStaticStrings.promotedShops,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),

          CustomText(
            AppStaticStrings.promotedShopsDesc,
            fontSize: 14,
            color: AppColors.kSecondaryTextColor,
            textAlign: TextAlign.center,
          ),

          Flexible(
            child: SingleChildScrollView(
              child: Column(
                spacing: 8,
                children: List.generate(
                  3,
                  (index) => PromotedShopCardWidget(
                    shopName: "Mug & Muffin",
                    shopImg:
                        "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop",
                    items: const [
                      {
                        "title": "Hot Coffee",
                        "price": "AED 24.6",
                        "image":
                            "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?q=80&w=2070&auto=format&fit=crop",
                      },
                      {
                        "title": "Hot Coffee",
                        "price": "AED 24.6",
                        "image":
                            "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?q=80&w=2070&auto=format&fit=crop",
                      },
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FractionallySizedBox(
        heightFactor: 0.8,
        child: PromotedShopsSheet(),
      ),
    );
  }
}
