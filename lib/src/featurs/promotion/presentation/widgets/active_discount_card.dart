import '../../../../src_export.dart';

class ActiveDiscountCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String dateRange;
  final String discount;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ActiveDiscountCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.dateRange,
    required this.discount,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(appRadius),
      ),
      child: Column(
        children: [
          Row(
            spacing: 6,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.kGreenColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.percent, color: Colors.white, size: 24),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 6,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          title,
                          variant: TextVariant.titleMedium,
                          fontWeight: FontWeight.bold,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.kGreenColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: CustomText(
                            discount,
                            variant: TextVariant.labelMedium,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 6,
                      children: [
                        const Icon(
                          Icons.circle,
                          size: 14,
                          color: AppColors.kRedColor,
                        ),

                        CustomText(
                          subtitle,
                          variant: TextVariant.labelSmall,
                          color: AppColors.kPrimaryColor,
                        ),
                      ],
                    ),
                    CustomText(
                      AppStaticStrings.appliedToAllCoffeePastries,
                      variant: TextVariant.labelSmall,
                      color: AppColors.kSecondaryTextColor,
                    ),
                    Row(
                      spacing: 6,
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: AppColors.kSecondaryTextColor,
                        ),

                        CustomText(
                          dateRange,
                          variant: TextVariant.labelSmall,
                          color: AppColors.kSecondaryTextColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            spacing: 6,
            children: [
              Expanded(
                child: CustomButton(
                  text: AppStaticStrings.edit,
                  onPressed: onEdit,
                  icon: Icons.edit,
                  isExpanding: true,
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.kRedColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppColors.kRedColor,
                  ),
                  onPressed: onDelete,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
