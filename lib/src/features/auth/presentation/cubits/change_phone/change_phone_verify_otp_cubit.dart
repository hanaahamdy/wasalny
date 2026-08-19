part of '../../imports/view_imports.dart';

class ChangePhoneVerifyOtpCubit extends VerifyOtpCubit {
  @override
  Future<void> verify({required String phone, required String otp}) async {
    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams<BaseModel?>(
          api: ApiConstants.changePhoneCurrentVerify,
          body: {'code': otp},
          httpRequestType: HttpRequestType.post,
          isFromData: true,
          mapper: (json) => BaseModel.fromJson(json),
        ),
      ),
      successEmitter: (_) => Go.back(true),
    );
  }
}
