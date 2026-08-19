part of '../../imports/view_imports.dart';

class LoginVerifyOtpCubit extends VerifyOtpCubit {
  @override
  Future<void> verify({required String phone, required String otp}) async {
    await _verifyAccount(
      phone: phone,
      otp: otp,
      successEmitter: _handleAuthenticatedUser,
    );
  }
}
