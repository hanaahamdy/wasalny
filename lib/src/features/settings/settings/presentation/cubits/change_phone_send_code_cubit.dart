part of '../imports/view_imports.dart';

class ChangePhoneSendCodeCubit extends AsyncCubit<BaseModel?> {
  ChangePhoneSendCodeCubit() : super(null);

  Future<void> sendCode(String phone) async {
    Go.to(
      OtpVerificationScreen(
        phone: phone,
        purpose: OtpPurpose.confirmNewPhone,
      ),
    );
    // await executeAsync(
    //   operation: () async => baseCrudUseCase.call(
    //     CrudBaseParams<BaseModel?>(
    //       api: ApiConstants.changeEmailSendCode,
    //       body: {'phone': phone},
    //       httpRequestType: HttpRequestType.post,
    //       isFromData: true,
    //       mapper: (json) => BaseModel.fromJson(json),
    //     ),
    //   ),
    //   successEmitter: (_) {
    //     Go.to(
    //       OtpVerificationScreen(
    //         phone: phone,
    //         purpose: OtpPurpose.confirmNewPhone,
    //       ),
    //     );
    //   },
    // );
  }
}
