part of '../imports/view_imports.dart';

class OrdersCubit extends Cubit<int> {
  OrdersCubit({UserType? userType})
    : userType = userType ?? UserCubit.instance.user.userType,
      super(0);

  final UserType userType;

  bool get isAdmin => userType == UserType.admin;

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
