part of '../imports/view_imports.dart';

class OrdersState extends Equatable {
  final BaseStatus status;
  final int selectedIndex;
  final List<OrderModel> orders;
  final String? errorMessage;

  const OrdersState({
    this.status = BaseStatus.initial,
    this.selectedIndex = 0,
    this.orders = const [],
    this.errorMessage,
  });

  OrdersState copyWith({
    BaseStatus? status,
    int? selectedIndex,
    List<OrderModel>? orders,
    String? errorMessage,
    bool clearError = false,
  }) {
    return OrdersState(
      status: status ?? this.status,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      orders: orders ?? this.orders,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, selectedIndex, orders, errorMessage];
}
