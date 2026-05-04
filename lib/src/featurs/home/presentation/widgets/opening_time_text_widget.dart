import '../../../../src_export.dart';

class OpeningTimeTextWidget extends StatelessWidget {
  const OpeningTimeTextWidget({super.key, this.openHours, this.isOpen});

  final String? openHours;
  final bool? isOpen;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.access_time_filled,
          size: 16,
          color: isOpen == false ? AppColors.kRedColor : AppColors.kGreenColor,
        ),
        const SizedBox(width: 6),
        CustomText(
          "${isOpen == false ? "" : AppStaticStrings.open} ${openHours ?? "7:00 AM - 9:00 PM"}",
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isOpen == false ? AppColors.kRedColor : AppColors.kGreenColor,
        ),
      ],
    );
  }
}
