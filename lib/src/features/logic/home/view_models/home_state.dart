part of 'home_cubit.dart';

class HomeState {
  final BaseStatus status;
  final HomeModel? data;
  final String errorMessage;

  const HomeState({
    this.status = BaseStatus.initial,
    this.data,
    this.errorMessage = '',
  });

  HomeState copyWith({
    BaseStatus? status,
    HomeModel? data,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
