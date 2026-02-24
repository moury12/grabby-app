import '../../../../src_export.dart';

class RewardSettingsPage extends StatefulWidget {
  const RewardSettingsPage({super.key});

  @override
  State<RewardSettingsPage> createState() => _RewardSettingsPageState();
}

class _RewardSettingsPageState extends State<RewardSettingsPage> {
  bool isRewardPointsAccepted = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: CustomText(
          AppStaticStrings.rewardSettings,
          variant: TextVariant.titleLarge,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // TODO: Implement UI sections
          ],
        ),
      ),
    );
  }
}
