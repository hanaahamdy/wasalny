part of '../../imports/presentation_imports.dart';

class CreateOrdersCubit extends Cubit<CreateOrdersState>
    with CreateOrdersMixin {
  final CreateOrderRepository _repository;

  CreateOrdersCubit({CreateOrderRepository? repository})
    : _repository = repository ?? injector<CreateOrderRepository>(),
      super(const CreateOrdersState());

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
