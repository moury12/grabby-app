
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../src_export.dart';

class ShopOrderDetailsPage extends StatefulWidget {
  final String orderId;
  const ShopOrderDetailsPage({super.key, required this.orderId});

  @override
  State<ShopOrderDetailsPage> createState() => _ShopOrderDetailsPageState();
}

class _ShopOrderDetailsPageState extends State<ShopOrderDetailsPage> {
  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  void _fetchDetails() {
    context.read<OrderBloc>().add(FetchOrderDetailsEvent(widget.orderId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        title: CustomText(
          "#${widget.orderId}",
          variant: TextVariant.headlineMedium,
        ),
      ),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state.status == OrderStatus.success && state.successMessage != null && state.successMessage!.contains("Order status updated")) {
            _fetchDetails();
            // Optional: return true to refresh parent list
          }
           if (state.status == OrderStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? "Error")),
            );
          }
        },
        builder: (context, state) {
          if (state.status == OrderStatus.loading && state.selectedOrder == null) {
            return const Center(child: CircularProgressIndicator());
          }
          final order = state.selectedOrder;
          if (order == null) {
            return const Center(child: CustomText("Order not found"));
          }

          return RefreshIndicator(
            onRefresh: () async => _fetchDetails(),
            child: SingleChildScrollView(
              padding: AppPadding.getPadding12(context).copyWith(top: 0),
              child: Column(
                spacing: 8,
                children: [
                  _buildStatusStepper(order.status ?? ""),
                  _buildPickupInfo(order),
                  _buildMapSection(order),
                  _buildItemsSection(order),
                  _buildActionButtons(order, state.status == OrderStatus.updating),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusStepper(String currentStatus) {
    final List<String> statuses = [
      'placed',
      'preparing',
      'ready',
      'completed',
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
          bool isCompleted = _isStatusCompleted(status, currentStatus);
          bool isCurrent = currentStatus.toLowerCase() == status.toLowerCase();

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
                status.toUpperCase(),
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

  bool _isStatusCompleted(String status, String currentStatus) {
    final List<String> order = ['placed', 'preparing', 'ready', 'completed'];
    int currentIdx = order.indexOf(currentStatus.toLowerCase());
    int statusIdx = order.indexOf(status.toLowerCase());
    return statusIdx < currentIdx;
  }

  Widget _buildPickupInfo(OrderModel order) {
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
              CustomText(
                order.pickupType == "carPickup" ? "Car Pickup (${order.carPlates})" : "Walk-in",
                variant: TextVariant.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection(OrderModel order) {
    final branch = order.branchId is BranchInfo ? (order.branchId as BranchInfo) : null;
    final lat = branch?.lat ?? 25.2048;
    final lng = branch?.lng ?? 55.2708;

    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.kAccentColor,
        borderRadius: BorderRadius.circular(appRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(appRadius),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(lat, lng),
            zoom: 14,
          ),
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          markers: {
            Marker(markerId: const MarkerId('shop'), position: LatLng(lat, lng)),
          },
        ),
      ),
    );
  }

  Widget _buildItemsSection(OrderModel order) {
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
          ...order.items.map((item) => _buildItemRow("${item.quantity}x ${item.menuName}", "AED ${item.totalPrice?.toStringAsFixed(2)}")),
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
                "${order.totalAmount.toStringAsFixed(2)} AED",
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

  Widget _buildActionButtons(OrderModel order, bool isUpdating) {
    String mainButtonText = "";
    String nextStatus = "";
    final currentStatus = order.status?.toLowerCase();

    if (currentStatus == 'placed') {
      mainButtonText = AppStaticStrings.startPreparing;
      nextStatus = 'preparing';
    } else if (currentStatus == 'preparing') {
      mainButtonText = AppStaticStrings.markAsReady;
      nextStatus = 'ready';
    } else if (currentStatus == 'ready') {
      mainButtonText = AppStaticStrings.completeOrder;
      nextStatus = 'completed';
    }

    return Column(
      children: [
        if (mainButtonText.isNotEmpty)
          CustomButton(
            text: mainButtonText,
            isLoading: isUpdating,
            onPressed: () {
              context.read<OrderBloc>().add(UpdateOrderStatusEvent(
                orderId: order.id ?? "",
                status: nextStatus,
              ));
            },
          ),
        CustomButton(
          text: AppStaticStrings.cancelOrder,
          onPressed: () {
             context.read<OrderBloc>().add(UpdateOrderStatusEvent(
                orderId: order.id ?? "",
                status: 'cancelled',
              ));
          },
          backgroundColor: Colors.white,
          textColor: AppColors.kRedColor,
          borderColor: AppColors.kRedColor,
        ),
      ],
    );
  }
}
