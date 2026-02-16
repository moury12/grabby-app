import '../../../../src_export.dart';

class AddCarPlatePage extends StatefulWidget {
  const AddCarPlatePage({super.key});

  @override
  State<AddCarPlatePage> createState() => _AddCarPlatePageState();
}

class _AddCarPlatePageState extends State<AddCarPlatePage> {
  final TextEditingController _plateController = TextEditingController();

  @override
  void dispose() {
    _plateController.dispose();
    super.dispose();
  }

  List<String> carNumberSource = [
    "Abu dhabi",
    "Dubai",
    "Sharjah",
    "Ajman",
    "Umm al quwain",
    "Ras al khaimah",
    "Fujairah",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStaticStrings.addNewPlate)),
      body: Padding(
        padding: AppPadding.getPadding12(context),
        child: Column(
          spacing: 12,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                const CustomText(
                  AppStaticStrings.carNumberSource,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 8,
                    children: List.generate(
                      carNumberSource.length,
                      (index) => Container(
                        padding: AppPadding.getPadding8(context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey.withValues(alpha: 0.3),
                          ),
                        ),
                        child: CustomText(carNumberSource[index]),
                      ),
                    ),
                  ),
                ),
                const CustomText(
                  AppStaticStrings.enterPlateNumber,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                TextField(
                  controller: _plateController,
                  decoration: InputDecoration(
                    hintText: "e.g. ABC 1234",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey.withValues(alpha: 0.3),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            CustomButton(
              text: AppStaticStrings.addNewPlate,
              onPressed: () {
                // In a real app, this would add the plate to local storage/API
                context.pop();
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
