import '../../../../src_export.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({super.key});

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  String _selectedMilk = "Fresh Milk";
  final List<String> _selectedExtras = ["Extra Shot of Espresso"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hot Spanish Latte")),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context),
        child: Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Info Card
            Container(
              padding: AppPadding.getPadding12(context),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          "Hot Spanish Latte",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          "2x espresso, steamed milk, sweetened condensed milk",
                          fontSize: 14,
                          color: AppColors.kSecondaryTextColor,
                        ),
                      ],
                    ),
                  ),
                  const CustomNetworkImage(
                    imageUrl:
                        "https://images.unsplash.com/photo-1541167760496-162955ed8a9f?q=80&w=2033&auto=format&fit=crop",
                    height: 100,
                    width: 100,
                    radius: 12,
                  ),
                ],
              ),
            ),

            // Choice of Milk
            _buildSection(
              title: "Choice of Milk",
              children: [
                _buildOptionChip(
                  label: "Fresh Milk",
                  subtitle: "AED 0",
                  isSelected: _selectedMilk == "Fresh Milk",
                  onTap: () => setState(() => _selectedMilk = "Fresh Milk"),
                ),
                _buildOptionChip(
                  label: "Oat Milk",
                  subtitle: "AED 5",
                  isSelected: _selectedMilk == "Oat Milk",
                  onTap: () => setState(() => _selectedMilk = "Oat Milk"),
                ),
              ],
            ),

            // Your Choice of
            _buildSection(
              title: "Your Choice of",

              children: [
                _buildOptionChip(
                  label: "Extra Shot of Espresso",
                  subtitle: "AED 5",
                  isSelected: _selectedExtras.contains(
                    "Extra Shot of Espresso",
                  ),
                  onTap: () => _toggleExtra("Extra Shot of Espresso"),
                ),
                _buildOptionChip(
                  label: "Standard Temperature",
                  subtitle: "AED 0",
                  isSelected: _selectedExtras.contains("Standard Temperature"),
                  onTap: () => _toggleExtra("Standard Temperature"),
                ),
                _buildOptionChip(
                  label: "Extra Hot",
                  subtitle: "AED 0",
                  isSelected: _selectedExtras.contains("Extra Hot"),
                  onTap: () => _toggleExtra("Extra Hot"),
                ),
                _buildOptionChip(
                  label: "Less Milk Not Full",
                  subtitle: "AED 0",
                  isSelected: _selectedExtras.contains("Less Milk Not Full"),
                  onTap: () => _toggleExtra("Less Milk Not Full"),
                ),
                _buildOptionChip(
                  label: "No Cover",
                  subtitle: "AED 0",
                  isSelected: _selectedExtras.contains("No Cover"),
                  onTap: () => _toggleExtra("No Cover"),
                ),
                _buildOptionChip(
                  label: "With Cover",
                  subtitle: "AED 0",
                  isSelected: _selectedExtras.contains("With Cover"),
                  onTap: () => _toggleExtra("With Cover"),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: AppPadding.getPadding16(context),
        child: CustomButton(
          text: "${AppStaticStrings.addToCart} 12.3 AED",
          onPressed: () {
            context.pushNamed(RoutesPath.cartPath);
          },
        ),
      ),
    );
  }

  void _toggleExtra(String extra) {
    setState(() {
      if (_selectedExtras.contains(extra)) {
        _selectedExtras.remove(extra);
      } else {
        _selectedExtras.add(extra);
      }
    });
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(title, fontSize: 18, fontWeight: FontWeight.bold),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: children
              .map(
                (child) => SizedBox(
                  width: (MediaQuery.of(context).size.width - 44) / 3,
                  // height: 70,
                  child: child,
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildOptionChip({
    required String label,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ButtonTapWidget(
      onTap: onTap,
      child: Container(
        padding: AppPadding.getPadding8(context),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFA59BF9) : const Color(0xFFE8E7FF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : Colors.grey.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          spacing: 4,
          children: [
            CustomText(
              label,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              color: isSelected ? Colors.white : const Color(0xFF3F3D56),
            ),
            CustomText(
              subtitle,
              fontSize: 10,
              color: isSelected
                  ? Colors.white.withValues(alpha: 0.8)
                  : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
