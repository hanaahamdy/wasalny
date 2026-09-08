part of '../../imports/view_imports.dart';

final class ResetPasswordState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final String? successMessage;

  const ResetPasswordState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.successMessage,
  });

  ResetPasswordState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) => ResetPasswordState(
    isLoading: isLoading ?? this.isLoading,
    isSuccess: isSuccess ?? this.isSuccess,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    successMessage: clearSuccess ? null : successMessage ?? this.successMessage,
  );
}
