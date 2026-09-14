part of '../../imports/presentation_imports.dart';

class CreateOrdersCubit extends Cubit<CreateOrdersState>
    with CreateOrdersMixin {
  final CreateOrderRepository _repository;

  CreateOrdersCubit({CreateOrderRepository? repository})
    : _repository = repository ?? injector<CreateOrderRepository>(),
      super(const CreateOrdersState()) {
    initializeOrderItems();
  }

  static const sellerOptions = ['seller_one', 'seller_two', 'seller_three'];

  void selectSeller(String? seller) {
    if (seller == null) return;
    emit(state.copyWith(seller: seller));
  }

  void prefillCustomer({required String name, required String phone}) {
    customerNameController.text = name;
    phoneController.text = phone;
  }

  void addOrderItem() {
    orderItems.add(createOrderItemControllers());
    emit(state.copyWith(itemCount: orderItems.length));
  }

  void removeOrderItem(int index) {
    if (orderItems.length == 1) return;
    orderItems.removeAt(index).dispose();
    calculateTotals();
    emit(state.copyWith(itemCount: orderItems.length));
  }

  Future<void> createOrder() async {
    if (state.isLoading || formKey.currentState?.validate() != true) return;
    emit(
      state.copyWith(
        isLoading: true,
        isSuccess: false,
        clearError: true,
        clearSuccess: true,
      ),
    );
    final params = CreateOrderParams(
      name: customerNameController.text.trim(),
      phone: phoneController.text.trim(),
      totalAmount: totalController.text.trim(),
      deliveryFee: deliveryPriceController.text.trim(),
      partnerPrice: partnerPriceController.text.trim(),
      seller: state.seller!,
      products: orderItems
          .map(
            (item) => CreateOrderProductParams(
              productName: item.productName.text.trim(),
              quantity: item.quantity.text.trim(),
              price: item.price.text.trim(),
            ),
          )
          .toList(),
    );
    final result = await _repository.createOrder(params);
    result.when(
      (response) => emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          successMessage: response.message,
          createdOrder: response.order,
        ),
      ),
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
    );
  }
}
