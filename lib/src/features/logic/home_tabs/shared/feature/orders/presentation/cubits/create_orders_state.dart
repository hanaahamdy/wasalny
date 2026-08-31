part of '../imports/view_imports.dart';

final class CreateOrdersState {
  final bool isLoading;
  final int itemCount;

  const CreateOrdersState({this.isLoading = false, this.itemCount = 1});

  CreateOrdersState copyWith({bool? isLoading, int? itemCount}) {
    return CreateOrdersState(
      isLoading: isLoading ?? this.isLoading,
      itemCount: itemCount ?? this.itemCount,
    );
  }
}
