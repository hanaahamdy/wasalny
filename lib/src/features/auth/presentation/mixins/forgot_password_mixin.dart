part of '../imports/view_imports.dart';

mixin ForgotPasswordMixin on Cubit<ForgotPasswordState> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
