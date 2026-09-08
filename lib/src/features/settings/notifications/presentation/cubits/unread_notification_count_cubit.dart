import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/res/config_imports.dart';
import '../../domain/repositories/notifications_repository.dart';

@lazySingleton
class UnreadNotificationCountCubit extends Cubit<int> {
  UnreadNotificationCountCubit() : super(0);

  late final NotificationsRepository _repository = injector();

  Future<void> fetchUnreadCount() async {
    final result = await _repository.fetchUnreadCount();
    result.when((count) => emit(count), (failure) => emit(0));
  }

  void decrementCount() {
    if (state > 0) {
      emit(state - 1);
    }
  }

  void resetCount() {
    emit(0);
  }

  void setCount(int count) {
    emit(count);
  }

  @override
  void emit(int state) {
    if (isClosed) return;
    super.emit(state);
  }
}
