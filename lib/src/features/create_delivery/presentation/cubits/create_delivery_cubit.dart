part of '../imports/presentation_imports.dart';

class CreateDeliveryCubit extends Cubit<CreateDeliveryState>
    with CreateDeliveryControllers {
  final CreateDeliveryRepository _repository;

  CreateDeliveryCubit({CreateDeliveryRepository? repository})
    : _repository = repository ?? injector<CreateDeliveryRepository>(),
      super(const CreateDeliveryState());

  Future<void> createDelivery() async {
    if (state.isLoading || formKey.currentState?.validate() != true) return;
    emit(
      state.copyWith(
        isLoading: true,
        isSuccess: false,
        clearError: true,
        clearSuccess: true,
      ),
    );
    final result = await _repository.createDelivery(
      CreateDeliveryParams(
        name: fullNameController.text.trim(),
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
      ),
    );
    result.when(
      (message) => emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          successMessage: message,
        ),
      ),
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
    );
  }
}
