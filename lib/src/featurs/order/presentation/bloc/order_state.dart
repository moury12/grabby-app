
part of 'order_bloc.dart';

enum OrderStatus { initial, loading, success, failure, updating }

class OrderState {
  final OrderStatus status;
  final List<OrderModel> orders;
  final OrderModel? selectedOrder;
  final String? errorMessage;
  final String? successMessage;

  OrderState({
    this.status = OrderStatus.initial,
    this.orders = const [],
    this.selectedOrder,
    this.errorMessage,
    this.successMessage,
  });

  OrderState copyWith({
    OrderStatus? status,
    List<OrderModel>? orders,
    OrderModel? selectedOrder,
    String? errorMessage,
    String? successMessage,
  }) {
    return OrderState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      selectedOrder: selectedOrder ?? this.selectedOrder,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}
