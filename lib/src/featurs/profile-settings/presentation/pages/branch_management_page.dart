import '../../../../src_export.dart';

class BranchManagementPage extends StatefulWidget {
  const BranchManagementPage({super.key});

  @override
  State<BranchManagementPage> createState() => _BranchManagementPageState();
}

class _BranchManagementPageState extends State<BranchManagementPage> {
  void _showAddBranch() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddBranchBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          AppStaticStrings.branchManagement,
          variant: TextVariant.headlineSmall,
          // fontWeight: FontWeight.bold,
        ),
        actions: [
          FloatingActionButton.small(
            onPressed: _showAddBranch,
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12H(context),
        child: Column(
          children: [
            _buildSummaryCard(context),
            space2H,
            BranchCard(
              name: "Downtown Branch",
              isDefault: true,
              address: "123 Main Street, San Francisco, CA 94102",
              phone: "+1 (555) 123-4567",
              hours: "Mon-Fri: 7AM-8PM, Sat-Sun: 8AM-6PM",
              onEdit: () {},
              onDelete: () {},
            ),
            BranchCard(
              name: "Marina District",
              address: "123 Main Street, San Francisco, CA 94102",
              phone: "+1 (555) 123-4567",
              hours: "Mon-Fri: 7AM-8PM, Sat-Sun: 8AM-6PM",
              onEdit: () {},
              onDelete: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    return Padding(
      padding: AppPadding.getPadding12(context),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _SummaryItem(
            label: AppStaticStrings.totalBranches,
            value: "3",
            color: AppColors.kPrimaryColor,
          ),
          _SummaryItem(
            label: AppStaticStrings.active,
            value: "2",
            color: AppColors.kGreenColor,
          ),
          _SummaryItem(
            label: AppStaticStrings.inactive,
            value: "1",
            color: AppColors.kSecondaryTextColor,
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CustomText(
            value,
            variant: TextVariant.titleLarge,
            color: color,
            fontWeight: FontWeight.bold,
          ),
          CustomText(
            label,
            variant: TextVariant.labelSmall,
            color: AppColors.kSecondaryTextColor,
          ),
        ],
      ),
    );
  }
}
