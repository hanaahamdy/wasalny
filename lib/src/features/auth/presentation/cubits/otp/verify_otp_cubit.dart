part of '../../imports/view_imports.dart';

abstract class VerifyOtpCubit extends AsyncCubit<BaseModel?> {
  VerifyOtpCubit() : super(null);

  Future<void> verify({required String phone, required String otp});

  factory VerifyOtpCubit.fromPurpose(OtpPurpose purpose) {
    return switch (purpose) {
      OtpPurpose.login => LoginVerifyOtpCubit(),
      OtpPurpose.loginMarketer => LoginVerifyOtpCubit(),
      OtpPurpose.register => RegisterVerifyOtpCubit(),
      OtpPurpose.resetPassword => ResetPasswordVerifyOtpCubit(),
      OtpPurpose.changePhone => ChangePhoneVerifyOtpCubit(),
      OtpPurpose.confirmNewPhone => ConfirmNewPhoneVerifyOtpCubit(),
    };
  }

  Future<void> _verifyAccount({
    required String phone,
    required String otp,
    void Function(BaseModel? success)? successEmitter,
  }) async {
    Go.to(const HomeScreen());
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
