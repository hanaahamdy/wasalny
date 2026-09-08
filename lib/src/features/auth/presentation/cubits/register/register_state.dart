part of '../../imports/view_imports.dart';

final class RegisterState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const RegisterState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    bool clearError = false,
  }) => RegisterState(
    isLoading: isLoading ?? this.isLoading,
    isSuccess: isSuccess ?? this.isSuccess,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
}
