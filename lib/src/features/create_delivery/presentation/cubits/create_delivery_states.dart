final class CreateDeliveryState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final String? successMessage;

  const CreateDeliveryState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.successMessage,
  });

  CreateDeliveryState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) => CreateDeliveryState(
    isLoading: isLoading ?? this.isLoading,
    isSuccess: isSuccess ?? this.isSuccess,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    successMessage: clearSuccess ? null : successMessage ?? this.successMessage,
  );
}
