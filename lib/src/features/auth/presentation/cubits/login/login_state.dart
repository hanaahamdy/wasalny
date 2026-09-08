part of '../../imports/view_imports.dart';

final class LoginState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const LoginState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    bool clearError = false,
  }) => LoginState(
    isLoading: isLoading ?? this.isLoading,
    isSuccess: isSuccess ?? this.isSuccess,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
  );
}
