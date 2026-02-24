import '../../../../src_export.dart';

class UpcomingEventCard extends StatelessWidget {
  final String title;
  final String date;
  final String icon;

  const UpcomingEventCard({
    super.key,
    required this.title,
    required this.date,
    required this.icon,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(icon, variant: TextVariant.headlineMedium),
          const SizedBox(height: 8),
          CustomText(
            title,
            variant: TextVariant.titleMedium,
            fontWeight: FontWeight.bold,
          ),
          CustomText(
            date,
            variant: TextVariant.labelSmall,
            color: AppColors.kSecondaryTextColor,
          ),
        ],
      ),
    );
  }
}
