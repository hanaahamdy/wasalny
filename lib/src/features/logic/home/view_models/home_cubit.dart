import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/res/config_imports.dart';
import '../../../../core/extensions/base_state.dart';
import '../../../../core/extensions/errors/error_handler_extension.dart';
import '../../../../core/network/network_service.dart';
import '../models/home_model.dart';
import '../services/home_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({HomeService? homeService})
    : _homeService = homeService ?? HomeService(injector<NetworkService>()),
      super(const HomeState());

  final HomeService _homeService;

  Future<void> fetchHome() async {
    if (state.status.isLoading) return;
    emit(state.copyWith(status: BaseStatus.loading, errorMessage: ''));

    final result = await _homeService.fetchHome().handleCallbackWithFailure();
    result.when(
      (data) => emit(state.copyWith(status: BaseStatus.success, data: data)),
      (failure) => emit(
        state.copyWith(status: BaseStatus.error, errorMessage: failure.message),
      ),
    );
  }
}
