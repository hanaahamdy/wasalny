part of '../imports/view_imports.dart';

class ProfileCubit extends AsyncCubit<UserModel?> {
  ProfileCubit() : super(UserCubit.instance.user);

  Future<bool> updateProfile(UpdateProfileParams params) async {
    final currentUser = UserCubit.instance.user;
    final updatedUser = currentUser.copyWith(
      fullName: params.fullName,
      birthDate: params.birthDate,
      email: params.email,
      location: params.location,
      gender: params.gender,
      city: params.cityName ?? '',
      district: params.districtName ?? '',
    );

    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams<UserModel?>(
          api: ApiConstants.updateProfile,
          body: params.toJson(),
          httpRequestType: HttpRequestType.post,
          isFromData: true,
          mapper: (json) {
            final response = Map<String, dynamic>.from(json as Map);
            final data = response['data'];
            return data is Map
                ? UserModel.fromJson(Map<String, dynamic>.from(data))
                : updatedUser;
          },
        ),
      ),
    );

    final returnedUser = state.data;
    if (!state.isSuccess || returnedUser == null) return false;

    await UserCubit.instance.updateUser(returnedUser);
    return true;
  }

  Future<void> fetchProfile() async {
    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams<UserModel?>(
          api: ApiConstants.profile,
          httpRequestType: HttpRequestType.get,
          mapper: (json) {
            final response = Map<String, dynamic>.from(json as Map);
            final data = response['data'];
            return data is Map
                ? UserModel.fromJson(Map<String, dynamic>.from(data))
                : null;
          },
        ),
      ),
      showErrorToast: false,
      successEmitter: (user) {
        if (user != null) UserCubit.instance.updateUser(user);
      },
    );
  }
}
