import '../../../../src_export.dart';

class ShopOwnerOnboardingPage extends StatefulWidget {
  const ShopOwnerOnboardingPage({super.key});

  @override
  State<ShopOwnerOnboardingPage> createState() =>
      _ShopOwnerOnboardingPageState();
}

class _ShopOwnerOnboardingPageState extends State<ShopOwnerOnboardingPage> {
  bool isTabletDedicated = false;

  final List<Map<String, String>> benefits = [
    {
      'title': AppStaticStrings.instantSetup,
      'icon': ImagesConstant.kVerifiedIcon,
    },
    {'title': AppStaticStrings.shopExposure, 'icon': ImagesConstant.kSoundIcon},
    {
      'title': AppStaticStrings.onDemandSupport,
      'icon': ImagesConstant.kCallIcon2,
    },
    {
      'title': AppStaticStrings.customerLoyalty,
      'icon': ImagesConstant.kLoyalityStamps,
    },
  ];

  final List<Map<String, String>> faqs = [
    {
      'question': AppStaticStrings.faqQuestion1,
      'answer': AppStaticStrings.faqAnswer1,
    },
    {
      'question': AppStaticStrings.faqQuestion2,
      'answer': AppStaticStrings.faqAnswer2,
    },
    {
      'question': AppStaticStrings.faqQuestion3,
      'answer': AppStaticStrings.faqAnswer3,
    },
    {
      'question': AppStaticStrings.faqQuestion4,
      'answer': AppStaticStrings.faqAnswer4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.getPadding12(context),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo Header
              Center(
                child: Container(
                  padding: AppPadding.getPadding12(context),
                  // height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(appRadius16),
                  ),
                  child: Center(
                    child: Image.asset(ImagesConstant.kAppIcon, height: 120),
                  ),
                ),
              ),

              // Business Benefits Section
              Center(
                child: const CustomText(
                  AppStaticStrings.whatYourBusinessWillReceive,
                  variant: TextVariant.headlineSmall,
                  // fontWeight: FontWeight.bold,
                ),
              ),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2,
                ),
                itemCount: benefits.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: AppPadding.getPadding8(context),
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          benefits[index]['icon']!,
                          height: 24,
                          width: 24,
                          colorFilter: const ColorFilter.mode(
                            AppColors.kPrimaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),

                      CustomText(
                        benefits[index]['title']!,
                        variant: TextVariant.labelMedium,
                        color: AppColors.kPrimaryColor,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
              //

              // Fees Structure Card
              Container(
                width: double.infinity,
                padding: AppPadding.getPadding8(context),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8E5FF),
                  borderRadius: BorderRadius.circular(appRadius),
                ),
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: CustomText(
                        AppStaticStrings.feesStructure,
                        variant: TextVariant.titleMedium,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    _buildFeeItem(AppStaticStrings.noSetupFees),
                    _buildFeeItem(AppStaticStrings.serviceFee10),
                    _buildFeeItem(AppStaticStrings.onlinePaymentProcessingFee),
                    _buildFeeItem(AppStaticStrings.marketingPlanOneOfAny),

                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.kTextColor.withValues(alpha: 0.7),
                        ),
                        children: [
                          const TextSpan(text: AppStaticStrings.agreementNote),
                          const TextSpan(
                            text: AppStaticStrings.termsAndConditions,
                            style: TextStyle(
                              color: AppColors.kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Checkbox Section
              Row(
                children: [
                  Checkbox(
                    value: isTabletDedicated,
                    activeColor: AppColors.kPrimaryColor,
                    onChanged: (value) {
                      setState(() {
                        isTabletDedicated = value ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: CustomText(
                      AppStaticStrings.tabletDedicatedCheck,
                      variant: TextVariant.labelSmall,
                    ),
                  ),
                ],
              ),

              // FAQ Section
              const Center(
                child: CustomText(
                  AppStaticStrings.frequentlyAskedQuestions,
                  variant: TextVariant.titleMedium,
                  fontWeight: FontWeight.bold,
                ),
              ),

              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: faqs.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    childrenPadding: EdgeInsets.zero,

                    title: CustomText(
                      "${index + 1}. ${faqs[index]['question']}",
                      variant: TextVariant.labelMedium,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      CustomText(
                        faqs[index]['answer']!,
                        variant: TextVariant.bodySmall,
                        color: AppColors.kSecondaryTextColor,
                      ),
                    ],
                  );
                },
              ),

              // Next Button
              CustomButton(
                text: AppStaticStrings.next,
                onPressed: () {
                  context.go(RoutesPath.loginPath);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeeItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText("• ", variant: TextVariant.labelMedium),
          Expanded(child: CustomText(text, variant: TextVariant.labelMedium)),
        ],
      ),
    );
  }
}
