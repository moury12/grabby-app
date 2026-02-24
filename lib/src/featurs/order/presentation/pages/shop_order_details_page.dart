import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../src_export.dart';

class ShopOrderDetailsPage extends StatefulWidget {
  const ShopOrderDetailsPage({super.key});

  @override
  State<ShopOrderDetailsPage> createState() => _ShopOrderDetailsPageState();
}

class _ShopOrderDetailsPageState extends State<ShopOrderDetailsPage> {
  String currentStatus = AppStaticStrings.pending;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        title: CustomText(
          "#ORD-1234",
          variant: TextVariant.headlineMedium,
          // fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: AppPadding.getPadding12(context).copyWith(top: 0),
        child: Column(
          spacing: 8,
          children: [
            _buildStatusStepper(),
            _buildPickupInfo(),
            _buildMapSection(),
            _buildItemsSection(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusStepper() {
    final List<String> statuses = [
      AppStaticStrings.placedStatus,
      AppStaticStrings.acceptedStatus,
      AppStaticStrings.preparing,
      AppStaticStrings.ready,
      AppStaticStrings.completed,
    ];

    return Container(
      padding: AppPadding.getPadding8(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(appRadius),
      ),
      child: Column(
        children: statuses.asMap().entries.map((entry) {
          int idx = entry.key;
          String status = entry.value;
          bool isCompleted = _isStatusCompleted(status);
          bool isCurrent =
              currentStatus == status ||
              (currentStatus == AppStaticStrings.pending &&
                  status == AppStaticStrings.placedStatus);

          return Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: isCompleted || isCurrent
                          ? AppColors.kPrimaryColor
                          : Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: isCompleted
                        ? const Icon(Icons.check, color: Colors.white, size: 16)
                        : null,
                  ),
                  if (idx != statuses.length - 1)
                    Container(
                      width: 2,
                      height: 20,
                      color: isCompleted
                          ? AppColors.kPrimaryColor
                          : Colors.grey.shade300,
                    ),
                ],
              ),
              const SizedBox(width: 12),
              CustomText(
                status,
                variant: TextVariant.bodyMedium,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                color: isCompleted || isCurrent
                    ? AppColors.kTextColor
                    : AppColors.kSecondaryTextColor,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  bool _isStatusCompleted(String status) {
    // Very simple mock logic for the stepper
    final List<String> order = [
      AppStaticStrings.placedStatus,
      AppStaticStrings.acceptedStatus,
      AppStaticStrings.preparing,
      AppStaticStrings.ready,
      AppStaticStrings.completed,
    ];
    int currentIdx = order.indexOf(
      currentStatus == AppStaticStrings.pending
          ? AppStaticStrings.placedStatus
          : currentStatus,
    );
    int statusIdx = order.indexOf(status);
    return statusIdx < currentIdx;
  }

  Widget _buildPickupInfo() {
    return Container(
      padding: AppPadding.getPadding8(context),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(appRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            AppStaticStrings.pickupDetails,
            variant: TextVariant.titleMedium,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 8),
          Row(
            spacing: 8,
            children: [
              SvgPicture.asset(ImagesConstant.kGroupIcon),
              CustomText("Counter Pickup", variant: TextVariant.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.kAccentColor,
        borderRadius: BorderRadius.circular(appRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(appRadius),
        child: Stack(
          children: [
            const GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(25.2048, 55.2708), // Example location
                zoom: 14,
              ),
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              markers: {},
            ),
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  spacing: 8,
                  children: [
                    const Icon(
                      Icons.navigation_outlined,
                      color: AppColors.kPrimaryColor,
                      size: 16,
                    ),
                    CustomText(
                      AppStaticStrings.customerIsOnTheWay,
                      variant: TextVariant.labelMedium,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsSection() {
    return Container(
      padding: AppPadding.getPadding8(context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(appRadius),
      ),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            AppStaticStrings.orderItems,
            variant: TextVariant.titleMedium,
            fontWeight: FontWeight.bold,
          ),
          _buildItemRow("2x Caffe Latte", "9.00 AED"),
          const Divider(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                AppStaticStrings.orderTotal,
                variant: TextVariant.titleMedium,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                "21.10 AED",
                variant: TextVariant.titleLarge,
                color: AppColors.kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(String name, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(name, variant: TextVariant.bodyMedium),
        CustomText(price, variant: TextVariant.titleSmall),
      ],
    );
  }

  Widget _buildActionButtons() {
    String mainButtonText = "";
    VoidCallback? onMainTap;

    if (currentStatus == AppStaticStrings.pending) {
      mainButtonText = AppStaticStrings.startPreparing;
      onMainTap = () =>
          setState(() => currentStatus = AppStaticStrings.preparing);
    } else if (currentStatus == AppStaticStrings.preparing) {
      mainButtonText = AppStaticStrings.markAsReady;
      onMainTap = () => setState(() => currentStatus = AppStaticStrings.ready);
    } else if (currentStatus == AppStaticStrings.ready) {
      mainButtonText = AppStaticStrings.completeOrder;
      onMainTap = () =>
          setState(() => currentStatus = AppStaticStrings.completed);
    }

    return Column(
      // spacing: 12,
      children: [
        if (mainButtonText.isNotEmpty)
          CustomButton(text: mainButtonText, onPressed: onMainTap!),
        CustomButton(
          text: AppStaticStrings.cancelOrder,
          onPressed: () {},
          backgroundColor: Colors.white,
          textColor: AppColors.kRedColor,
          borderColor: AppColors.kRedColor,
        ),
      ],
    );
  }
}
