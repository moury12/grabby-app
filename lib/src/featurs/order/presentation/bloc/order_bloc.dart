
import '../../../../src_export.dart';
import '../../domain/repositories/order_repository.dart';
import '../../data/models/order_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _orderRepository;

  OrderBloc(this._orderRepository) : super(OrderState()) {
    on<CreateOrderEvent>(_onCreateOrder);
    on<FetchMyOrdersEvent>(_onFetchMyOrders);
    on<FetchOrderDetailsEvent>(_onFetchOrderDetails);
    on<FetchBranchOrdersEvent>(_onFetchBranchOrders);
    on<UpdateOrderStatusEvent>(_onUpdateOrderStatus);
    on<CancelOrderEvent>(_onCancelOrder);
  }

  Future<void> _onCreateOrder(CreateOrderEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStatus.loading));
    try {
      final response = await _orderRepository.createOrder(event.order);
      if (response.success && response.data != null) {
        emit(state.copyWith(
          status: OrderStatus.success,
          selectedOrder: response.data,
          successMessage: response.message,
        ));
      } else {
        emit(state.copyWith(status: OrderStatus.failure, errorMessage: response.message));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(status: OrderStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(status: OrderStatus.failure, errorMessage: "Failed to create order."));
    }
  }

  Future<void> _onFetchMyOrders(FetchMyOrdersEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStatus.loading));
    try {
      final response = await _orderRepository.getMyOrders(
        status: event.status,
        page: event.page,
        limit: event.limit,
      );
      if (response.success) {
        emit(state.copyWith(
          status: OrderStatus.success,
          orders: response.data ?? [],
        ));
      } else {
        emit(state.copyWith(status: OrderStatus.failure, errorMessage: response.message));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(status: OrderStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(status: OrderStatus.failure, errorMessage: "Failed to fetch orders."));
    }
  }

  Future<void> _onFetchOrderDetails(FetchOrderDetailsEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStatus.loading));
    try {
      final response = await _orderRepository.getOrderDetails(event.orderId);
      if (response.success && response.data != null) {
        emit(state.copyWith(
          status: OrderStatus.success,
          selectedOrder: response.data,
        ));
      } else {
        emit(state.copyWith(status: OrderStatus.failure, errorMessage: response.message));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(status: OrderStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(status: OrderStatus.failure, errorMessage: "Failed to fetch order details."));
    }
  }

  Future<void> _onFetchBranchOrders(FetchBranchOrdersEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStatus.loading));
    try {
      final response = await _orderRepository.getBranchOrders(
        event.branchId,
        status: event.status,
        page: event.page,
        limit: event.limit,
      );
      if (response.success) {
        emit(state.copyWith(
          status: OrderStatus.success,
          orders: response.data ?? [],
        ));
      } else {
        emit(state.copyWith(status: OrderStatus.failure, errorMessage: response.message));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(status: OrderStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(status: OrderStatus.failure, errorMessage: "Failed to fetch branch orders."));
    }
  }

  Future<void> _onUpdateOrderStatus(UpdateOrderStatusEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStatus.updating));
    try {
      final response = await _orderRepository.updateOrderStatus(event.orderId, event.status);
      if (response.success && response.data != null) {
        emit(state.copyWith(
          status: OrderStatus.success,
          selectedOrder: response.data,
          successMessage: response.message,
        ));
      } else {
        emit(state.copyWith(status: OrderStatus.failure, errorMessage: response.message));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(status: OrderStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(status: OrderStatus.failure, errorMessage: "Failed to update order status."));
    }
  }

  Future<void> _onCancelOrder(CancelOrderEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(status: OrderStatus.loading));
    try {
      final response = await _orderRepository.cancelOrder(event.orderId);
      if (response.success && response.data != null) {
        emit(state.copyWith(
          status: OrderStatus.success,
          successMessage: response.message,
        ));
      } else {
        emit(state.copyWith(status: OrderStatus.failure, errorMessage: response.message));
      }
    } on ApiException catch (e) {
      emit(state.copyWith(status: OrderStatus.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(status: OrderStatus.failure, errorMessage: "Failed to cancel order."));
    }
  }
}
