part of '../imports/view_imports.dart';

class OrderItemControllers {
  final productName = TextEditingController();
  final quantity = TextEditingController();

  void dispose() {
    productName.dispose();
    quantity.dispose();
  }
}

mixin CreateOrdersMixin on Cubit<CreateOrdersState> {
  final formKey = GlobalKey<FormState>();
  final customerNameController = TextEditingController();
  final phoneController = TextEditingController();
  final deliveryPrice = TextEditingController();
  final totalController = TextEditingController();
  final List<OrderItemControllers> orderItems = [OrderItemControllers()];

  void prefillCustomer({required String name, required String phone}) {
    customerNameController.text = name;
    phoneController.text = phone;
  }

  void addOrderItem() {
    orderItems.add(OrderItemControllers());
    emit(state.copyWith(itemCount: orderItems.length));
  }

  void removeOrderItem(int index) {
    if (orderItems.length == 1) return;
    orderItems.removeAt(index).dispose();
    emit(state.copyWith(itemCount: orderItems.length));
  }

  void createOrder() {
    if (formKey.currentState?.validate() != true) return;
    Go.back(true);
  }

  @override
  Future<void> close() {
    customerNameController.dispose();
    phoneController.dispose();
    deliveryPrice.dispose();
    totalController.dispose();
    for (final item in orderItems) {
      item.dispose();
    }
    return super.close();
  }
}
