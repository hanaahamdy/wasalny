part of '../imports/view_imports.dart';

class ProfileChangePasswordCubit extends Cubit<RequestState<BaseModel?>> {
  final ProfileRepository _repository;

  ProfileChangePasswordCubit({ProfileRepository? repository})
    : _repository = repository ?? injector<ProfileRepository>(),
      super(const RequestState(data: null));

  Future<void> changePassword({
    required String currentPassword,
    required String password,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(status: BaseStatus.loading, clearError: true));
    final result = await _repository.changePassword(
      currentPassword: currentPassword,
      password: password,
      confirmPassword: confirmPassword,
    );
    await result.when(
      (success) async {
        emit(state.copyWith(status: BaseStatus.success, data: success));
        Go.back();
        await successDialog(
          context: Go.context,
          title: success?.message.isNotEmpty ?? false
              ? success!.message
              : LocaleKeys.changePassword,
        );
      },
      (failure) async {
        emit(
          state.copyWith(
            status: BaseStatus.error,
            errorMessage: failure.message,
          ),
        );
        MessageUtils.showSnackBar(
          baseStatus: BaseStatus.error,
          message: failure.message,
        );
        Go.back();
      },
    );
  }
}
