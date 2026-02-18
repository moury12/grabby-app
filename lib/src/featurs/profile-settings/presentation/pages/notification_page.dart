import '../../../../src_export.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        title: const Text(AppStaticStrings.notifications),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back, color: AppColors.kTextColor),
        ),
      ),
      body: ListView.separated(
        padding: AppPadding.getPadding12(context),
        itemCount: 3,
        separatorBuilder: (context, index) => space12H,
        itemBuilder: (context, index) {
          final notifications = [
            {
              'title': AppStaticStrings.notificationPaymentSuccessful,
              'desc': AppStaticStrings.notificationPaymentSuccessfulDesc,
              'time': "1 day ago",
              'icon': Icons.notifications_none_outlined,
            },
            {
              'title': AppStaticStrings.welcomeToGrabby,
              'desc': AppStaticStrings.welcomeToGrabbyDesc,
              'time': "1 day ago",
              'icon': Icons.notifications_none_outlined,
            },
            {
              'title': AppStaticStrings.notificationNewReservation,
              'desc': AppStaticStrings.notificationNewReservationDesc,
              'time': "1 day ago",
              'icon': Icons.notifications_none_outlined,
            },
          ];

          final item = notifications[index];

          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: AppColors.kPrimaryColor,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomText(
                              item['title'] as String,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CustomText(
                            item['time'] as String,
                            fontSize: 10,
                            color: AppColors.kSecondaryTextColor,
                          ),
                        ],
                      ),
                      CustomText(
                        item['desc'] as String,
                        fontSize: 12,
                        color: AppColors.kSecondaryTextColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
