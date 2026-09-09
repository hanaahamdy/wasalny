part of '../imports/view_imports.dart';

mixin LoginMixin on Cubit<AuthFormState> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    if (state.isLoading) return;
    // if (formKey.currentState?.validate() != true) return;
    Go.to(RoleSelectionScreen(email: emailController.text.trim()));
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
