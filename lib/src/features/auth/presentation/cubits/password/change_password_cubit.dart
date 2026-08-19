part of '../../imports/view_imports.dart';

class ChangePasswordCubit extends AsyncCubit<BaseModel?> {
  ChangePasswordCubit() : super(null);

  Future<void> changePassword({
    required String phone,
    required String verificationCode,
    required ResetPasswordParams params,
  }) async {
    if (!params.validate()) return;

    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams<BaseModel?>(
          api: ApiConstants.resetPassword,
          body: {
            'code': verificationCode,
            'password': params.passwordController.text,
            'password_confirmation': params.confirmPasswordController.text,
          },
          httpRequestType: HttpRequestType.post,
          isFromData: true,
          mapper: (json) =>
              BaseModel.fromJson(Map<String, dynamic>.from(json as Map)),
        ),
      ),
      successEmitter: (success) async {
        injector<NetworkService>().removeToken();
        await successDialog(
          context: Go.context,
          title: success?.message.isNotEmpty ?? false
              ? success!.message
              : LocaleKeys.changePassword,
        );
        Go.offAll(const LoginScreen());
      },
    );
  }
}
