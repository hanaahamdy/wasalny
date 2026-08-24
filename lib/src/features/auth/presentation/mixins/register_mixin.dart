part of '../imports/view_imports.dart';

mixin RegisterMixin on Cubit<AuthFormState> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void register() {
    if (formKey.currentState?.validate() != true) return;
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
