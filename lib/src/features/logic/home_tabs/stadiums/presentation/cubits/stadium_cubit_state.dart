part of '../imports/stadiums_imports.dart';

enum StadiumCubitStatus { initial, loading, success, error }

class StadiumCubitState<T> extends Equatable {
  final StadiumCubitStatus status;
  final T? data;
  final String? errorMessage;

  const StadiumCubitState({
    this.status = StadiumCubitStatus.initial,
    this.data,
    this.errorMessage,
  });

  bool get isLoading => status == StadiumCubitStatus.loading;
  bool get isSuccess => status == StadiumCubitStatus.success;
  bool get isError => status == StadiumCubitStatus.error;

  StadiumCubitState<T> loading() {
    return StadiumCubitState<T>(status: StadiumCubitStatus.loading, data: data);
  }

  StadiumCubitState<T> success(T data) {
    return StadiumCubitState<T>(status: StadiumCubitStatus.success, data: data);
  }

  StadiumCubitState<T> error(String message) {
    return StadiumCubitState<T>(
      status: StadiumCubitStatus.error,
      data: data,
      errorMessage: message,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
