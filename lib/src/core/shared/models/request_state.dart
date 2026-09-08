import 'package:equatable/equatable.dart';

import '../../extensions/base_state.dart';

class RequestState<T> extends Equatable {
  final BaseStatus status;
  final T data;
  final String? errorMessage;

  const RequestState({
    required this.data,
    this.status = BaseStatus.initial,
    this.errorMessage,
  });

  bool get isLoading => status.isLoading;
  bool get isSuccess => status.isSuccess;
  bool get isError => status.isError;

  RequestState<T> copyWith({
    BaseStatus? status,
    T? data,
    String? errorMessage,
    bool clearError = false,
  }) {
    return RequestState<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
