part of '../../imports/view_imports.dart';

final class ForgotPasswordOtpState {
  final int secondsLeft;
  final bool isResending;
  final bool isSuccess;
  final bool hasError;
  final String? errorMessage;
  final String? successMessage;

  const ForgotPasswordOtpState({
    this.secondsLeft = 60,
    this.isResending = false,
    this.isSuccess = false,
    this.hasError = false,
    this.errorMessage,
    this.successMessage,
  });

  ForgotPasswordOtpState copyWith({
    int? secondsLeft,
    bool? isResending,
    bool? isSuccess,
    bool? hasError,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) => ForgotPasswordOtpState(
    secondsLeft: secondsLeft ?? this.secondsLeft,
    isResending: isResending ?? this.isResending,
    isSuccess: isSuccess ?? this.isSuccess,
    hasError: hasError ?? this.hasError,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    successMessage: clearSuccess ? null : successMessage ?? this.successMessage,
  );
}
