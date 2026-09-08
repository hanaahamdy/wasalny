part of '../imports/view_imports.dart';

class ProfileCubit extends Cubit<RequestState<UserModel?>> {
  final ProfileRepository _repository;

  ProfileCubit({ProfileRepository? repository})
    : _repository = repository ?? injector<ProfileRepository>(),
      super(RequestState(data: UserCubit.instance.user));

  Future<bool> updateProfile(UpdateProfileParams params) async {
    final currentUser = UserCubit.instance.user;
    final updatedUser = currentUser.copyWith(
      name: params.fullName,
      email: params.email,
      address: params.location,
    );

    emit(state.copyWith(status: BaseStatus.loading, clearError: true));
    final result = await _repository.updateProfile(params, updatedUser);
    return await result.when(
      (user) async {
        if (user == null) return false;
        emit(state.copyWith(status: BaseStatus.success, data: user));
        await UserCubit.instance.updateUser(user);
        return true;
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
        return false;
      },
    );
  }

  Future<void> fetchProfile() async {
    emit(state.copyWith(status: BaseStatus.loading, clearError: true));
    final result = await _repository.fetchProfile();
    result.when(
      (user) {
        emit(state.copyWith(status: BaseStatus.success, data: user));
        if (user != null) UserCubit.instance.updateUser(user);
      },
      (failure) => emit(
        state.copyWith(status: BaseStatus.error, errorMessage: failure.message),
      ),
    );
  }
}
