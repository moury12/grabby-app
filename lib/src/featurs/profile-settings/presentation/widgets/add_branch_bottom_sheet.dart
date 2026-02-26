import '../../../../src_export.dart';

class AddBranchBottomSheet extends StatefulWidget {
  const AddBranchBottomSheet({super.key});

  @override
  State<AddBranchBottomSheet> createState() => _AddBranchBottomSheetState();
}

class _AddBranchBottomSheetState extends State<AddBranchBottomSheet> {
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.getPadding16(context),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        spacing: 12,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 6,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                AppStaticStrings.addNewBranch,
                variant: TextVariant.headlineSmall,
                fontWeight: FontWeight.bold,
              ),
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),

          // _buildFieldLabel(AppStaticStrings.branchName),
          const CustomTextField(
            title: AppStaticStrings.branchName,
            hintText: AppStaticStrings.branchNamePrompt,
          ),

          // _buildFieldLabel(AppStaticStrings.fullAddress),
          ButtonTapWidget(
            onTap: () async {
              final result = await context.pushNamed(
                RoutesPath.locationSelectionName,
              );
              if (result != null && result is Map<String, dynamic>) {
                setState(() {
                  _addressController.text = result['address'] ?? '';
                });
              }
            },
            child: CustomTextField(
              title: AppStaticStrings.fullAddress,

              textEditingController: _addressController,
              isEnable: false,
              hintText: AppStaticStrings.enterCompleteAddress,
            ),
          ),

          // _buildFieldLabel(AppStaticStrings.phoneNumber),
          const CustomTextField(
            title: AppStaticStrings.phoneNumber,
            hintText: "+1 (555) 000-0000",
          ),

          // _buildFieldLabel(AppStaticStrings.operatingHours),
          const CustomTextField(
            title: AppStaticStrings.operatingHours,

            hintText: "e.g., Mon-Fri: 7AM-8PM, Sat-Sun: 8AM-6PM",
          ),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.kBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              spacing: 6,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        AppStaticStrings.activateBranch,
                        variant: TextVariant.titleSmall,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        AppStaticStrings.startAcceptingOrdersImmediately,
                        variant: TextVariant.labelSmall,
                        color: AppColors.kSecondaryTextColor,
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: true,
                  onChanged: (val) {},
                  activeColor: AppColors.kPrimaryColor,
                ),
              ],
            ),
          ),

          CustomButton(
            text: AppStaticStrings.addBranch,
            onPressed: () => context.pop(),
          ),

          CustomButton(
            text: AppStaticStrings.cancel,
            onPressed: () => context.pop(),
            isOutlined: true,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: CustomText(
        label,
        variant: TextVariant.labelMedium,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
