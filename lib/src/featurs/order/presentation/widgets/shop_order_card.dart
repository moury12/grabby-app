import '../../../../src_export.dart';

class ShopOrderCard extends StatelessWidget {
  final String orderId;
  final String time;
  final String customerName;
  final int orderCount;
  final int stampCount;
  final List<Map<String, dynamic>> items;
  final String status;
  final String pickupType;
  final String totalPrice;
  final bool isPaid;
  final VoidCallback? onTap;

  const ShopOrderCard({
    super.key,
    required this.orderId,
    required this.time,
    required this.customerName,
    required this.orderCount,
    required this.stampCount,
    required this.items,
    required this.status,
    required this.pickupType,
    required this.totalPrice,
    this.isPaid = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTapWidget(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: AppPadding.getPadding12(context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(appRadius),
        ),
        child: Column(
          spacing: 6,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      orderId,
                      variant: TextVariant.titleLarge,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      time,
                      variant: TextVariant.labelSmall,
                      color: AppColors.kSecondaryTextColor,
                    ),
                  ],
                ),
                _buildStatusBanner(status),
              ],
            ),

            CustomText(
              customerName,
              variant: TextVariant.titleMedium,
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              "$orderCount ${AppStaticStrings.ordersCount} \u2022 $stampCount ${AppStaticStrings.stampsCount}",
              variant: TextVariant.labelSmall,
              color: AppColors.kSecondaryTextColor,
            ),

            const Divider(height: 1, color: AppColors.kAccentColor),

            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      "${item['qty']}x ${item['name']}",
                      variant: TextVariant.bodyMedium,
                    ),
                    CustomText(
                      "${item['price']}AED",
                      variant: TextVariant.titleSmall,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ),

            const Divider(height: 1, color: AppColors.kAccentColor),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    if (isPaid)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.kGreenColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: CustomText(
                          AppStaticStrings.paid,
                          variant: TextVariant.labelSmall,
                          color: AppColors.kGreenColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(appRadius),
                      ),
                      child: Row(
                        spacing: 4,
                        children: [
                          Icon(
                            pickupType.contains('Car')
                                ? Icons.directions_car_filled_outlined
                                : Icons.person_outline,
                            size: 16,
                            color: AppColors.kPrimaryColor,
                          ),
                          CustomText(
                            pickupType,
                            variant: TextVariant.labelSmall,
                            color: AppColors.kPrimaryColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                CustomText(
                  "$totalPrice AED",
                  variant: TextVariant.headlineMedium,
                  color: AppColors.kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBanner(String status) {
    Color color;
    switch (status) {
      case AppStaticStrings.pending:
        color = Colors.orange;
        break;
      case AppStaticStrings.preparing:
        color = AppColors.kBlueColor;
        break;
      case AppStaticStrings.ready:
        color = AppColors.kGreenColor;
        break;
      case AppStaticStrings.completed:
        color = AppColors.kSecondaryTextColor;
        break;
      default:
        color = AppColors.kPrimaryColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        spacing: 4,
        children: [
          Icon(
            status == AppStaticStrings.ready
                ? Icons.check_circle_outline
                : Icons.access_time,
            size: 16,
            color: color,
          ),
          CustomText(
            status,
            variant: TextVariant.labelLarge,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
