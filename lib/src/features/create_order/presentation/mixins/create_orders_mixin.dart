part of '../imports/presentation_imports.dart';

class OrderItemControllers {
  final productName = TextEditingController();
  final quantity = TextEditingController();
  final price = TextEditingController();

  OrderItemControllers({required VoidCallback onTotalsChanged}) {
    quantity.addListener(onTotalsChanged);
    price.addListener(onTotalsChanged);
  }

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
  final deliveryPriceController = TextEditingController(text: '10.00');
  final partnerPriceController = TextEditingController(text: '0.00');
  final totalController = TextEditingController(text: '10.00');
  late final List<OrderItemControllers> orderItems;

  void initializeOrderItems() {
    orderItems = [createOrderItemControllers()];
  }

  OrderItemControllers createOrderItemControllers() =>
      OrderItemControllers(onTotalsChanged: calculateTotals);

  void calculateTotals() {
    final piecesSubtotal = orderItems.fold<double>(0, (sum, item) {
      final price = double.tryParse(item.price.text.trim()) ?? 0;
      final quantity = double.tryParse(item.quantity.text.trim()) ?? 0;
      return sum + (price * quantity);
    });
    final partnerPrice = piecesSubtotal * 0.10;
    const deliveryPrice = 10.0;
    partnerPriceController.text = partnerPrice.toStringAsFixed(2);
    deliveryPriceController.text = deliveryPrice.toStringAsFixed(2);
    totalController.text = (piecesSubtotal + partnerPrice + deliveryPrice)
        .toStringAsFixed(2);
  }

  @override
  Future<void> close() {
    customerNameController.dispose();
    phoneController.dispose();
    deliveryPriceController.dispose();
    partnerPriceController.dispose();
    totalController.dispose();
    for (final item in orderItems) {
      item.dispose();
    }
    return super.close();
  }
}
