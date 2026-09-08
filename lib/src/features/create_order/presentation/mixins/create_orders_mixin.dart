part of '../imports/presentation_imports.dart';

class OrderItemControllers {
  final productName = TextEditingController();
  final quantity = TextEditingController();
  final price = TextEditingController();

  void dispose() {
    productName.dispose();
    quantity.dispose();
    price.dispose();
  }
}

mixin CreateOrdersMixin on Cubit<CreateOrdersState> {
  final formKey = GlobalKey<FormState>();
  final customerNameController = TextEditingController();
  final phoneController = TextEditingController();
  final deliveryPriceController = TextEditingController();
  final totalController = TextEditingController();
  final List<OrderItemControllers> orderItems = [OrderItemControllers()];

  @override
  Future<void> close() {
    customerNameController.dispose();
    phoneController.dispose();
    deliveryPriceController.dispose();
    totalController.dispose();
    for (final item in orderItems) {
      item.dispose();
    }
    return super.close();
  }
}
