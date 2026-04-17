import '../../../../src_export.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({super.key});

  @override
  State<PromotionPage> createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {


  void _showEditDiscount({String? title, PromotionModel? promotion}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EditDiscountBottomSheet(title: title, promotion: promotion),
    );
  }

  void _showDeleteDialog(PromotionModel promotion) {
    final currentContext = context;
    showDialog(
      context: context,
      builder: (dialogContext) => DeleteDiscountDialog(discountName: promotion.discountName),
    ).then((confirmed) {
      if (confirmed == true && mounted) {
        currentContext.read<PromotionBloc>().add(DeletePromotionEvent(promotion.id));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PromotionBloc>()..add(GetPromotionsEvent()),
      child: Builder(
        builder: (context) {
          return BlocListener<PromotionBloc, PromotionState>(
            listener: (context, state) {
              if (state is PromotionOperationSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
                context.pop();
              } else if (state is PromotionError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message, style: const TextStyle(color: Colors.white))),
                );
              }
            },
            child: Scaffold(
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
              body: RefreshIndicator(
                onRefresh: () async => context.read<PromotionBloc>().add(GetPromotionsEvent()),
                child: BlocBuilder<PromotionBloc, PromotionState>(
                  builder: (context, state) {
                    if (state is PromotionLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PromotionError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(state.message, variant: TextVariant.bodyLarge),
                            const SizedBox(height: 16),
                            CustomButton(
                              text: 'Retry',
                              onPressed: () => context.read<PromotionBloc>().add(GetPromotionsEvent()),
                            ),
                          ],
                        ),
                      );
                    } else if (state is PromotionsLoaded) {
                      return CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: AppPadding.getPadding12(context),
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

                                  // Dynamic active discounts from BLoC
                                  ...state.data.data.map((promotion) => ActiveDiscountCard(
                                        title: promotion.discountName,
                                        subtitle: promotion.eventName ?? 'Event',
                                        dateRange: '${promotion.startDate.toString().split('T')[0]} - ${promotion.endDate.toString().split('T')[0]}',
                                        discount: '${promotion.discountValue}%',
                                        onEdit: () => _showEditDiscount(promotion: promotion),
                                        onDelete: () => _showDeleteDialog(promotion),
                                      )),

                                  // If no promotions, show empty state
                                  if (state.data.data.isEmpty)
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(32),
                                        child: Column(
                                          children: [
                                            const Icon(Icons.discount_outlined, size: 64, color: Colors.grey),
                                            const SizedBox(height: 16),
                                            CustomText(
                                              'No active promotions',
                                              variant: TextVariant.titleMedium,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(height: 8),
                                            CustomText(
                                              'Create your first promotion to get started',
                                              variant: TextVariant.bodyMedium,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
