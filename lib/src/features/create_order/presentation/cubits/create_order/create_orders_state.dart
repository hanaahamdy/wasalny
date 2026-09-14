part of '../../imports/presentation_imports.dart';

final class CreateOrdersState {
  final bool isLoading;
  final bool isSuccess;
  final int itemCount;
  final String? seller;
  final String? errorMessage;
  final String? successMessage;
  final CreatedOrderModel? createdOrder;

  const CreateOrdersState({
    this.isLoading = false,
    this.isSuccess = false,
    this.itemCount = 1,
    this.seller,
    this.errorMessage,
    this.successMessage,
    this.createdOrder,
  });

  CreateOrdersState copyWith({
    bool? isLoading,
    bool? isSuccess,
    int? itemCount,
    String? seller,
    String? errorMessage,
    String? successMessage,
    CreatedOrderModel? createdOrder,
    bool clearError = false,
    bool clearSuccess = false,
  }) => CreateOrdersState(
    isLoading: isLoading ?? this.isLoading,
    isSuccess: isSuccess ?? this.isSuccess,
    itemCount: itemCount ?? this.itemCount,
    seller: seller ?? this.seller,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    successMessage: clearSuccess ? null : successMessage ?? this.successMessage,
    createdOrder: createdOrder ?? this.createdOrder,
  );
}
