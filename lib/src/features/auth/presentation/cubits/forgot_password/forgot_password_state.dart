part of '../../imports/view_imports.dart';

final class ForgotPasswordState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final String? successMessage;

  const ForgotPasswordState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.successMessage,
  });

  ForgotPasswordState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) => ForgotPasswordState(
    isLoading: isLoading ?? this.isLoading,
    isSuccess: isSuccess ?? this.isSuccess,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    successMessage: clearSuccess ? null : successMessage ?? this.successMessage,
  );
}
