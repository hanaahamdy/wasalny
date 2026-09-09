import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/res/config_imports.dart';
import '../../../../../../../core/extensions/base_state.dart';
import '../../../../../../../core/shared/models/request_state.dart';
import '../../domain/repositories/admin_home_repository.dart';
import '../../entity/admin_home_model.dart';

class AdminHomeCubit extends Cubit<RequestState<AdminHomeModel?>> {
  final AdminHomeRepository _repository;

  AdminHomeCubit({AdminHomeRepository? repository})
    : _repository = repository ?? injector<AdminHomeRepository>(),
      super(const RequestState(data: null));

  Future<void> fetchHome() async {
    if (state.isLoading) return;
    emit(state.copyWith(status: BaseStatus.loading, clearError: true));
    final result = await _repository.fetchHome();
    result.when(
      (data) => emit(state.copyWith(status: BaseStatus.success, data: data)),
      (failure) => emit(
        state.copyWith(status: BaseStatus.error, errorMessage: failure.message),
      ),
    );
  }
}
