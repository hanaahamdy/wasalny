part of '../imports/view_imports.dart';

class DeliveryOrderStatusCubit extends Cubit<RequestState<DeliveryOrderTab>> {
  final OrderModel order;
  final OrdersRepository _repository;

  DeliveryOrderStatusCubit({required this.order, OrdersRepository? repository})
    : _repository =
          repository ??
          OrdersRepositoryImpl(
            OrdersRemoteDataSourceImpl(injector<NetworkService>()),
          ),
      super(RequestState(data: order.deliveryTab));

  Future<void> startDelivery() => _updateStatus(DeliveryOrderTab.delivering);

  Future<void> markAsDelivered() => _updateStatus(DeliveryOrderTab.delivered);

  Future<void> _updateStatus(DeliveryOrderTab status) async {
    final orderId = order.backendId;
    if (orderId == null || state.isLoading) return;

    emit(state.copyWith(status: BaseStatus.loading, clearError: true));
    final result = await _repository.updateDeliveryOrderStatus(
      orderId: orderId,
      status: status.apiValue,
    );
    result.when(
      (_) => emit(
        state.copyWith(
          status: BaseStatus.success,
          data: status,
          clearError: true,
        ),
      ),
      (failure) => emit(
        state.copyWith(status: BaseStatus.error, errorMessage: failure.message),
      ),
    );
  }
}
