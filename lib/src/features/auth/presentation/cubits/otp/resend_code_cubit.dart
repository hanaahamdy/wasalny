part of '../../imports/view_imports.dart';

class ResendCodeCubit extends AsyncCubit<BaseModel?> {
  ResendCodeCubit() : super(null);

  Future<void> resend({required String phone, required OtpPurpose purpose}) {
    final api = switch (purpose) {
      OtpPurpose.resetPassword => ApiConstants.forgetReSendCode,
      OtpPurpose.confirmNewPhone => ApiConstants.changeEmailReSendCode,
      OtpPurpose.changePhone => ApiConstants.changeEmailReSendCode,
      _ => ApiConstants.verifyAccountResendCode,
    };

    return executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams<BaseModel?>(
          api: api,
          body: {'phone': phone},
          httpRequestType: HttpRequestType.post,
          isFromData: true,
          mapper: (json) => BaseModel.fromJson(json),
        ),
      ),
    );
  }
}
