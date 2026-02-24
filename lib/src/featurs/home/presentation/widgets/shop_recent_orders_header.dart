import '../../../../src_export.dart';

class ShopRecentOrdersHeader extends StatefulWidget {
  const ShopRecentOrdersHeader({super.key});

  @override
  State<ShopRecentOrdersHeader> createState() => _ShopRecentOrdersHeaderState();
}

class _ShopRecentOrdersHeaderState extends State<ShopRecentOrdersHeader> {
  String selectedBranch = AppStaticStrings.branch;
  final List<String> branches = [
    AppStaticStrings.branch,
    "Downtown",
    "Uptown",
    "Main Street",
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          AppStaticStrings.recentOrders,
          variant: TextVariant.titleLarge,
          fontWeight: FontWeight.bold,
        ),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedBranch,
              icon: const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.kPrimaryColor,
                ),
              ),
              style: TextStyle(
                color: AppColors.kPrimaryColor,
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedBranch = newValue;
                  });
                }
              },
              items: branches.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: CustomText(
                    value,
                    variant: TextVariant.labelMedium,
                    color: AppColors.kPrimaryColor,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
