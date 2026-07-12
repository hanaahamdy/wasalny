part of '../imports/view_imports.dart';

class ChangePasswordCubit extends AsyncCubit<BaseModel?> {
  ChangePasswordCubit() : super(null);

  Future<void> changePassword({
    required String phone,
    required ResetPasswordParams params,
  }) async {
    if (!params.validate()) return;
    Go.offAll(const LoginScreen());
    // await executeAsync(
    //   operation: () async => baseCrudUseCase.call(
    //     CrudBaseParams<BaseModel?>(
    //       api: ApiConstants.resetPassword,
    //       body: {
    //         'phone': phone,
    //         'password': params.passwordController.text,
    //         'password_confirmation': params.confirmPasswordController.text,
    //       },
    //       httpRequestType: HttpRequestType.post,
    //       isFromData: true,
    //       mapper: (json) => BaseModel.fromJson(json),
    //     ),
    //   ),
    //   successEmitter: (success) async {
    //     await successDialog(
    //       context: Go.context,
    //       title: success?.message.isNotEmpty ?? false
    //           ? success!.message
    //           : LocaleKeys.changePassword,
    //     );
    //     Go.offAll(const LoginScreen());
    //   },
    // );
  }
}
