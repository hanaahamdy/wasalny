part of '../../imports/view_imports.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState>
    with ForgotPasswordMixin {
  final AuthRepository _repository;

  ForgotPasswordCubit({AuthRepository? repository})
    : _repository = repository ?? injector<AuthRepository>(),
      super(const ForgotPasswordState());

  Future<void> submit() async {
    if (state.isLoading || formKey.currentState?.validate() != true) return;
    emit(
      state.copyWith(
        isLoading: true,
        isSuccess: false,
        clearError: true,
        clearSuccess: true,
      ),
    );
    final result = await _repository.forgotPassword(
      emailController.text.trim(),
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
