import 'package:grabby_app/src/featurs/profile-settings/presentation/bloc/branch/branch_bloc.dart';

import '../../../../src_export.dart';

class AddBranchBottomSheet extends StatefulWidget {
  const AddBranchBottomSheet({super.key});

  @override
  State<AddBranchBottomSheet> createState() => _AddBranchBottomSheetState();
}

class _AddBranchBottomSheetState extends State<AddBranchBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  double _lat = 0.0;
  double _lng = 0.0;
  bool _applyMenuForAll = false;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_nameController.text.isEmpty || _addressController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final data = {
      "branch_name": _nameController.text.trim(),
      "address": _addressController.text.trim(),
      "lat": _lat,
      "lng": _lng,
      "phone_number": _phoneController.text.trim(),
      "applyMenuForAll": _applyMenuForAll,
    };

    context.read<BranchBloc>().add(CreateBranchEvent(data));
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: 12,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
            CustomTextField(
              title: AppStaticStrings.branchName,
              hintText: AppStaticStrings.branchNamePrompt,
              textEditingController: _nameController,
            ),
            ButtonTapWidget(
              onTap: () async {
                final result = await context.pushNamed(
                  RoutesPath.locationSelectionName,
                );
                if (result != null && result is Map<String, dynamic>) {
                  setState(() {
                    _addressController.text = result['address'] ?? '';
                    _lat = result['lat'] as double? ?? 0.0;
                    _lng = result['lng'] as double? ?? 0.0;
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
            CustomTextField(
              title: AppStaticStrings.phoneNumber,
              hintText: "+1 (555) 000-0000",
              textEditingController: _phoneController,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.kBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          "Apply Menu to All",
                          variant: TextVariant.titleSmall,
                          fontWeight: FontWeight.bold,
                        ),
                        const CustomText(
                          "Sync menu items across branches",
                          variant: TextVariant.labelSmall,
                          color: AppColors.kSecondaryTextColor,
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _applyMenuForAll,
                    onChanged: (val) {
                      setState(() {
                        _applyMenuForAll = val;
                      });
                    },
                    activeColor: AppColors.kPrimaryColor,
                  ),
                ],
              ),
            ),
            CustomButton(
              text: AppStaticStrings.addBranch,
              onPressed: _submit,
            ),
            CustomButton(
              text: AppStaticStrings.cancel,
              onPressed: () => context.pop(),
              isOutlined: true,
            ),
            const SizedBox(height: 10),
          ],
        ),
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
