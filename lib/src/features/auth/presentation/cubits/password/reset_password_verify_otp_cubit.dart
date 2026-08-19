part of '../../imports/view_imports.dart';

class ResetPasswordVerifyOtpCubit extends VerifyOtpCubit {
  @override
  Future<void> verify({required String phone, required String otp}) async {
    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams<BaseModel?>(
          api: ApiConstants.forgetCheckCode,
          body: {'code': otp},
          httpRequestType: HttpRequestType.post,
          isFromData: true,
          mapper: (json) =>
              BaseModel.fromJson(Map<String, dynamic>.from(json as Map)),
        ),
      ),
      successEmitter: (_) =>
          Go.to(ChangePasswordScreen(phone: phone, verificationCode: otp)),
    );
  }
}
