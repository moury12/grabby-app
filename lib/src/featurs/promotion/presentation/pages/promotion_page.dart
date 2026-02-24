import '../../../../src_export.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({super.key});

  @override
  State<PromotionPage> createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  void _showEditDiscount({String? title}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EditDiscountBottomSheet(title: title),
    );
  }

  void _showDeleteDialog(String name) {
    showDialog(
      context: context,
      builder: (context) => DeleteDiscountDialog(discountName: name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          AppStaticStrings.promotions,
          variant: TextVariant.headlineSmall,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                onPressed: () =>
                    _showEditDiscount(title: AppStaticStrings.addPromotion),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding16H(context),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              AppStaticStrings.upcomingEvents,
              variant: TextVariant.titleLarge,
              fontWeight: FontWeight.bold,
            ),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.7,
              ),
              itemCount: 3,
              itemBuilder: (context, index) {
                final events = [
                  {
                    "title": AppStaticStrings.ramadanSpecial,
                    "date": "Feb 28 - Mar 30, 2026",
                    "icon": "🌙",
                  },
                  {
                    "title": "Eid Al-Fitr",
                    "date": "Mar 30 - Apr 2, 2026",
                    "icon": "🎉",
                  },
                  {
                    "title": "Valentine's Day",
                    "date": "February 14, 2026",
                    "icon": "💝",
                  },
                ];
                final event = events[index];
                return UpcomingEventCard(
                  title: event['title']!,
                  date: event['date']!,
                  icon: event['icon']!,
                );
              },
            ),

            Row(
              children: [
                const Icon(Icons.trending_up, color: AppColors.kGreenColor),

                CustomText(
                  AppStaticStrings.activeDiscounts,
                  variant: TextVariant.titleLarge,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),

            ActiveDiscountCard(
              title: AppStaticStrings.ramadanSpecial,
              subtitle: "Ramadan 2026",
              dateRange: "Feb 28, 2026 - Mar 30, 2026",
              discount: "20% OFF",
              onEdit: _showEditDiscount,
              onDelete: () =>
                  _showDeleteDialog(AppStaticStrings.ramadanSpecial),
            ),
            ActiveDiscountCard(
              title: AppStaticStrings.weekendDiscount,
              subtitle: "Weekend",
              dateRange: "Feb 28, 2026 - Mar 30, 2026",
              discount: "10% OFF",
              onEdit: _showEditDiscount,
              onDelete: () =>
                  _showDeleteDialog(AppStaticStrings.weekendDiscount),
            ),
            ActiveDiscountCard(
              title: AppStaticStrings.happyHour,
              subtitle: "Daily",
              dateRange: "Feb 28, 2026 - Mar 30, 2026",
              discount: "20% OFF",
              onEdit: _showEditDiscount,
              onDelete: () => _showDeleteDialog(AppStaticStrings.happyHour),
            ),
          ],
        ),
      ),
    );
  }
}
