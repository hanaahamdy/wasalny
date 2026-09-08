part of '../imports/view_imports.dart';

class DeleteNotificationCubit extends Cubit<RequestState<BaseModel?>> {
  final NotificationsCubit notificationsCubit;
  final NotificationsRepository _repository;

  DeleteNotificationCubit(
    this.notificationsCubit, {
    NotificationsRepository? repository,
  }) : _repository = repository ?? injector<NotificationsRepository>(),
       super(const RequestState(data: null));

  Future<void> deleteOneNotification(NotificationEntity notification) async {
    emit(state.copyWith(status: BaseStatus.loading, clearError: true));
    final result = await _repository.deleteOne(notification.id);

    result.when(
      (success) {
        emit(state.copyWith(status: BaseStatus.success, data: success));
        notificationsCubit.deleteOneNotification(notification);
        Go.back();
        MessageUtils.showSnackBar(
          baseStatus: BaseStatus.success,
          message: success?.message ?? '',
        );
      },
      (error) {
        _emitError(error.message);
        Go.back();
      },
    );
  }

  Future<void> deleteAllNotifications() async {
    emit(state.copyWith(status: BaseStatus.loading, clearError: true));
    final result = await _repository.deleteAll();

    result.when(
      (success) {
        emit(state.copyWith(status: BaseStatus.success, data: success));
        notificationsCubit.clearData();
        Go.back();
      },
      (error) {
        _emitError(error.message);
        Go.back();
      },
    );
  }

  void _emitError(String message) {
    emit(state.copyWith(status: BaseStatus.error, errorMessage: message));
    MessageUtils.showSnackBar(baseStatus: BaseStatus.error, message: message);
  }
}
