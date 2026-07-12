part of '../imports/view_imports.dart';

class ChangePhonePasswordCubit extends AsyncCubit<BaseModel?> {
  ChangePhonePasswordCubit() : super(null);

  Future<void> checkPassword(String password) async {
    Go.to(const ChangePhoneScreen());
    // await executeAsync(
    //   operation: () async => baseCrudUseCase.call(
    //     CrudBaseParams<BaseModel?>(
    //       api: ApiConstants.changeEmailCheckPassword,
    //       body: {'password': password},
    //       httpRequestType: HttpRequestType.post,
    //       isFromData: true,
    //       mapper: (json) => BaseModel.fromJson(json),
    //     ),
    //   ),
    //   successEmitter: (success) {
    //     Go.back();
    //     Go.to(const ChangePhoneScreen());
    //   },
    // );
  }
}
