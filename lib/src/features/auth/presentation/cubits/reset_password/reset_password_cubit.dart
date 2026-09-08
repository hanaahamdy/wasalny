part of '../../imports/view_imports.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState>
    with ResetPasswordMixin {
  final AuthRepository _repository;
  final String email;
  final String otp;

  ResetPasswordCubit({
    required this.email,
    required this.otp,
    AuthRepository? repository,
  }) : _repository = repository ?? injector<AuthRepository>(),
       super(const ResetPasswordState());

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
    final result = await _repository.resetPassword(
      email: email,
      otp: otp,
      password: passwordController.text,
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
