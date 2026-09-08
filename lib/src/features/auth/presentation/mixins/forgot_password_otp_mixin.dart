part of '../imports/view_imports.dart';

mixin ForgotPasswordOtpMixin on Cubit<ForgotPasswordOtpState> {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();
  final focusNode = FocusNode();

  @override
  Future<void> close() {
    otpController.dispose();
    focusNode.dispose();
    return super.close();
  }
}
