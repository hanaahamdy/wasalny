part of '../imports/view_imports.dart';

class RegisterCubit extends AsyncCubit<BaseModel?> {
  RegisterCubit() : super(null);

  Future<void> register(SignUpParams params) async {
    if (!params.validate()) return;

    await Go.to(
      OtpVerificationScreen(
        phone: params.phoneController.text.trim(),
        purpose: OtpPurpose.register,
      ),
    );
  }
}
