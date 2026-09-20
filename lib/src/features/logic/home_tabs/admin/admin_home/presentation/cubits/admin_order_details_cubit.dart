import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/res/config_imports.dart';
import '../../../../../../../core/extensions/base_state.dart';
import '../../../../../../../core/shared/models/request_state.dart';
import '../../../../shared/feature/orders/entity/order_model.dart';
import '../../domain/repositories/admin_home_repository.dart';

class AdminOrderDetailsCubit extends Cubit<RequestState<OrderModel>> {
  AdminOrderDetailsCubit({
    required OrderModel order,
    AdminHomeRepository? repository,
  }) : _repository = repository ?? injector<AdminHomeRepository>(),
       super(RequestState(data: order));

  final AdminHomeRepository _repository;

  Future<void> fetchOrderDetails() async {
    final orderId = state.data.backendId;
    if (orderId == null || state.isLoading) return;

    emit(state.copyWith(status: BaseStatus.loading, clearError: true));
    final result = await _repository.fetchOrderDetails(orderId);
    result.when(
      (order) => emit(state.copyWith(status: BaseStatus.success, data: order)),
      (failure) => emit(
        state.copyWith(status: BaseStatus.error, errorMessage: failure.message),
      ),
    );
  }
}
