import '../../../../src_export.dart';

class OpeningTimeTextWidget extends StatelessWidget {
  const OpeningTimeTextWidget({super.key, this.openHours});

  final String? openHours;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.access_time_filled, size: 16, color: AppColors.kGreenColor),
        const SizedBox(width: 6),
        CustomText(
          "${AppStaticStrings.open} ${openHours ?? "7:00 AM - 9:00 PM"}",
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.kGreenColor,
        ),
      ],
    );
  }
}
