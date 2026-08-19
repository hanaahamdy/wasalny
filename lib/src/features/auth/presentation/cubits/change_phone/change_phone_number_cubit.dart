part of '../../imports/view_imports.dart';

class ChangePhoneNumberCubit extends AsyncCubit<BaseModel?> {
  ChangePhoneNumberCubit() : super(null);

  Future<void> confirmNewPhone({required String phone, required String otp}) {
    return executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams<BaseModel?>(
          api: ApiConstants.changeEmailVerifyCode,
          body: {'phone': phone, 'code': otp},
          httpRequestType: HttpRequestType.post,
          isFromData: true,
          mapper: (json) => BaseModel.fromJson(json),
        ),
      ),
      successEmitter: (_) => Go.back(true),
    );
  }
}
