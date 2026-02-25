import '../../../../src_export.dart';

class OrderCard extends StatelessWidget {
  final String shopName;
  final String orderId;
  final List<String> items;
  final String dateTime;
  final String price;
  final String status;
  final bool isActive;

  const OrderCard({
    super.key,
    required this.shopName,
    required this.orderId,
    required this.items,
    required this.dateTime,
    required this.price,
    required this.status,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding12(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(shopName, fontSize: 16, fontWeight: FontWeight.bold),
              _buildStatusBadge(),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              CustomText(
                "${AppStaticStrings.order} $orderId",
                fontSize: 14,
                color: AppColors.kTextColor,
                fontWeight: FontWeight.w600,
              ),
              Row(
                spacing: 12,
                children: [
                  Row(
                    spacing: 4,
                    children: [
                      SvgPicture.asset(
                        ImagesConstant.kCarIcon,
                        height: 14,
                        colorFilter: const ColorFilter.mode(
                          AppColors.kSecondaryTextColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      const CustomText(
                        "Car - A 24204",
                        fontSize: 13,
                        color: AppColors.kSecondaryTextColor,
                      ),
                    ],
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color: AppColors.kSecondaryTextColor,
                      ),
                      CustomText(
                        dateTime,
                        fontSize: 13,
                        color: AppColors.kSecondaryTextColor,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                "${items.length} ${AppStaticStrings.itemsCount}",
                fontSize: 14,
                color: AppColors.kSecondaryTextColor,
              ),
              CustomText(price, fontSize: 16, fontWeight: FontWeight.bold),
            ],
          ),
          if (isActive)
            Row(
              spacing: 12,
              children: [
                Expanded(
                  child: CustomButton(
                    text: AppStaticStrings.trackOrder,
                    onPressed: () {
                      context.push(RoutesPath.orderTrackingPath);
                    },
                  ),
                ),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.push(RoutesPath.orderCanceledPath);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.kPrimaryColor),
                      // backgroundColor: const Color(0xFFF3F2FF),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const CustomText(
                      AppStaticStrings.cancelOrder,
                      color: AppColors.kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    bool isCompleted = status.toLowerCase() == "completed";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isCompleted ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          Icon(
            isCompleted ? Icons.check_circle_outline : Icons.card_giftcard,
            size: 14,
            color: isCompleted ? Colors.green : Colors.orange,
          ),
          CustomText(
            status,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: isCompleted ? Colors.green : Colors.orange,
          ),
        ],
      ),
    );
  }
}
