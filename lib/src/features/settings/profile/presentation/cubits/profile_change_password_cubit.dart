part of '../imports/view_imports.dart';

class ProfileChangePasswordCubit extends AsyncCubit<BaseModel?> {
  ProfileChangePasswordCubit() : super(null);

  Future<void> changePassword({
    required String currentPassword,
    required String password,
    required String confirmPassword,
  }) async {
    await executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams<BaseModel?>(
          api: ApiConstants.changePassword,
          body: {
            'old_password': currentPassword,
            'password': password,
            'password_confirmation': confirmPassword,
          },
          httpRequestType: HttpRequestType.post,
          isFromData: true,
          mapper: (json) => BaseModel.fromJson(json),
        ),
      ),
      successEmitter: (success) async {
        Go.back();
        await successDialog(
          context: Go.context,
          title: success?.message.isNotEmpty ?? false
              ? success!.message
              : LocaleKeys.changePassword,
        );
      },
    );
  }
}
