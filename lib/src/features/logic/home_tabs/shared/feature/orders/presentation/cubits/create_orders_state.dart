part of '../imports/view_imports.dart';

final class CreateOrdersState {
  final bool isLoading;

  const CreateOrdersState({this.isLoading = false});

  CreateOrdersState copyWith({bool? isLoading}) {
    return CreateOrdersState(isLoading: isLoading ?? this.isLoading);
  }
}
