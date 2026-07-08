part of '../imports/view_imports.dart';

enum OtpPurpose {
  login,
  loginMarketer,
  register,
  resetPassword,
  changePhone,
  confirmNewPhone,
}

extension OtpPurposeExtension on OtpPurpose {
  bool get isRegister => this == OtpPurpose.register;

  String get title {
    if (isRegister) return LocaleKeys.activationCode;
    if (this == OtpPurpose.resetPassword) return LocaleKeys.forgotPassword;

    return LocaleKeys.phoneNumberVerification;
  }

  String description(String phone) {
    final text = isRegister
        ? LocaleKeys.registerOtpDescription
        : LocaleKeys.pleaseEnterTheCodeSentTo;

    return '$text $phone';
  }
}
