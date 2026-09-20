part of '../imports/view_imports.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit({UserRole? userRole, OrdersRepository? repository})
    : userRole = userRole ?? UserCubit.instance.user.role,
      _repository =
          repository ??
          OrdersRepositoryImpl(
            OrdersRemoteDataSourceImpl(injector<NetworkService>()),
          ),
      super(const OrdersState());

  final UserRole userRole;
  final OrdersRepository _repository;

  bool get isAdmin => userRole == UserRole.admin;

  List<String> get tabs => isAdmin
      ? AdminOrderTab.values.map((tab) => tab.label).toList()
      : DeliveryOrderTab.values.map((tab) => tab.label).toList();

  List<OrderModel> get orders {
    if (isAdmin) {
      final selectedTab = AdminOrderTab.values[state.selectedIndex];
      return state.orders
          .where((order) => order.adminTab == selectedTab)
          .toList();
    }

    final selectedTab = DeliveryOrderTab.values[state.selectedIndex];
    return state.orders
        .where((order) => order.deliveryTab == selectedTab)
        .toList();
  }

  Future<void> fetchOrders() async {
    emit(state.copyWith(status: BaseStatus.loading, clearError: true));
    final result = await _repository.fetchOrders(isAdmin: isAdmin);
    result.when(
      (orders) =>
          emit(state.copyWith(status: BaseStatus.success, orders: orders)),
      (failure) => emit(
        state.copyWith(status: BaseStatus.error, errorMessage: failure.message),
      ),
    );
  }

  void selectTab(int index) => emit(state.copyWith(selectedIndex: index));
}
