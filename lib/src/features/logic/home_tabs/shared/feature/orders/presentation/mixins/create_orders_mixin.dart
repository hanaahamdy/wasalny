part of '../imports/view_imports.dart';

mixin CreateOrdersMixin on Cubit<CreateOrdersState> {
  final formKey = GlobalKey<FormState>();
  final customerNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final deliveryPrice = TextEditingController();
  final totalController = TextEditingController();
  final numberOfPieces = TextEditingController();

  void createOrder() {
    if (formKey.currentState?.validate() != true) return;
    Go.back(true);
  }

  @override
  Future<void> close() {
    customerNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    deliveryPrice.dispose();
    totalController.dispose();
    numberOfPieces.dispose();
    return super.close();
  }
}
