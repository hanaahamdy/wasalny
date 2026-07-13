part of '../imports/view_imports.dart';

abstract class VerifyOtpCubit extends AsyncCubit<BaseModel?> {
  VerifyOtpCubit() : super(null);

  Future<void> verify({required String phone, required String otp});

  factory VerifyOtpCubit.fromPurpose(OtpPurpose purpose) {
    return switch (purpose) {
      OtpPurpose.login => _LoginVerifyOtpCubit(),
      OtpPurpose.loginMarketer => _LoginVerifyOtpCubit(),
      OtpPurpose.register => _RegisterVerifyOtpCubit(),
      OtpPurpose.resetPassword => _ResetPasswordVerifyOtpCubit(),
      OtpPurpose.changePhone => _ChangePhoneVerifyOtpCubit(),
      OtpPurpose.confirmNewPhone => _ConfirmNewPhoneVerifyOtpCubit(),
    };
  }
}

class _LoginVerifyOtpCubit extends VerifyOtpCubit {
  @override
  Future<void> verify({required String phone, required String otp}) async {
    await _verifyAccount(
      phone: phone,
      otp: otp,
      successEmitter: _handleAuthenticatedUser,
    );
  }
}

class _RegisterVerifyOtpCubit extends VerifyOtpCubit {
  @override
  Future<void> verify({required String phone, required String otp}) async {
    await _verifyAccount(
      phone: phone,
      otp: otp,
      successEmitter: _handleAuthenticatedUser,
    );
  }
}

class _ResetPasswordVerifyOtpCubit extends VerifyOtpCubit {
  @override
  Future<void> verify({required String phone, required String otp}) async {
    Go.to(ChangePasswordScreen(phone: phone));
    // await executeAsync(
    //   operation: () async => baseCrudUseCase.call(
    //     CrudBaseParams<BaseModel?>(
    //       api: ApiConstants.forgetCheckCode,
    //       body: {'phone': phone, 'code': otp},
    //       httpRequestType: HttpRequestType.post,
    //       isFromData: true,
    //       mapper: (json) => BaseModel.fromJson(json),
    //     ),
    //   ),
    //   successEmitter: (_) {
    //     Go.to(const ResetPasswordScreen());
    //   },
    // );
  }
}

class _ChangePhoneVerifyOtpCubit extends VerifyOtpCubit {
  @override
  Future<void> verify({required String phone, required String otp}) async {
    await _verifyAccount(phone: phone, otp: otp);
  }
}

class _ConfirmNewPhoneVerifyOtpCubit extends VerifyOtpCubit {
  @override
  Future<void> verify({required String phone, required String otp}) async {
    // await executeAsync(
    //   operation: () async => baseCrudUseCase.call(
    //     CrudBaseParams<BaseModel?>(
    //       api: ApiConstants.changeEmailVerifyCode,
    //       body: {'phone': phone, 'code': otp},
    //       httpRequestType: HttpRequestType.post,
    //       isFromData: true,
    //       mapper: (json) => BaseModel.fromJson(json),
    //     ),
    //   ),
    //   successEmitter: (_) => Go.back(true),
    // );
    successDialog(context: Go.context, title: LocaleKeys.theMobilePhoneNumberHasBeenUpdatedSuccessfully,afterSuccess: () => Go.backToInitial());
  }
}

extension on VerifyOtpCubit {
  Future<void> _verifyAccount({
    required String phone,
    required String otp,
    void Function(BaseModel? success)? successEmitter,
  }) async {
    Go.to(const HomeScreen());
    // await executeAsync(
    //   operation: () async => baseCrudUseCase.call(
    //     CrudBaseParams<BaseModel?>(
    //       api: ApiConstants.verifyAccount,
    //       body: {
    //         'phone': phone,
    //         'code': otp,
    //       isFromData: true,
    //       mapper: (json) => BaseModel.fromJson(
    //         json,
    //         jsonToModel: (j) {
    //           final data = j['data'];
    //           if (data is Map<String, dynamic>) {
    //             return UserModel.fromJson(data);
    //           }
    //           return null;
    //         },
    //         'device_id': NotificationService.deviceToken,
    //         'device_type': Helpers.getDeviceType(),
    //         'project_name': ConstantManager.appName,
    //       },
    //       httpRequestType: HttpRequestType.post,
    //       ),
    //     ),
    //   ),
    //   successEmitter: successEmitter,
    // );
  }

  Future<void> _handleAuthenticatedUser(BaseModel? success) async {
    final user = success?.data is UserModel ? success!.data as UserModel : null;

    if (user == null) {
      await successDialog(
        context: Go.context,
        title: success?.message.isNotEmpty ?? false
            ? success!.message
            : LocaleKeys.verifyAccount,
      );
      Go.offAll(const LoginScreen());
      return;
    }
    await UserCubit.instance.setUserLoggedIn(
      user: user,
      token: user.token ?? ConstantManager.emptyText,
    );
    Go.offAll(const HomeScreen());
  }
}
