part of '../imports/view_imports.dart';

class ChangePhoneSendCodeCubit extends AsyncCubit<BaseModel?> {
  ChangePhoneSendCodeCubit() : super(null);

  Future<void> sendCode(String phone) async {
    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams<BaseModel?>(
          api: ApiConstants.changePhoneNewSend,
          body: {'country_code': '966', 'phone': phone},
          httpRequestType: HttpRequestType.post,
          isFromData: true,
          mapper: (json) => BaseModel.fromJson(json),
        ),
      ),
      successEmitter: (_) {
        Go.to(
          OtpVerificationScreen(
            phone: phone,
            purpose: OtpPurpose.confirmNewPhone,
          ),
        );
      },
    );
  }
}
