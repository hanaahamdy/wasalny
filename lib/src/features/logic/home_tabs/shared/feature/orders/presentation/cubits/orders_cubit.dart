part of '../imports/view_imports.dart';

class OrdersCubit extends Cubit<int> {
  OrdersCubit({UserRole? userRole})
    : userRole = userRole ?? UserCubit.instance.user.role,
      super(0);

  final UserRole userRole;

  bool get isAdmin => userRole == UserRole.admin;

  List<String> get tabs => isAdmin
      ? AdminOrderTab.values.map((tab) => tab.label).toList()
      : DeliveryOrderTab.values.map((tab) => tab.label).toList();

  List<OrderModel> get orders {
    if (isAdmin) {
      final selectedTab = AdminOrderTab.values[state];
      return OrderModel.samples
          .where((order) => order.adminTab == selectedTab)
          .toList();
    }

    final selectedTab = DeliveryOrderTab.values[state];
    return OrderModel.samples
        .where((order) => order.deliveryTab == selectedTab)
        .toList();
  }

  void selectTab(int index) => emit(index);
}
