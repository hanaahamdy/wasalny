part of '../imports/view_imports.dart';

mixin LoginMixin on Cubit<AuthFormState> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    if (state.isLoading) return;
    _loginAsAdmin();
  }

  Future<void> _loginAsAdmin() async {
    emit(state.copyWith(isLoading: true));
    final adminUser = UserModel.initial().copyWith(
      fullName: 'Admin',
      email: emailController.text.trim(),
      userType: UserType.delivery,
    );

    await UserCubit.instance.setUserLoggedIn(
      user: adminUser,
      token: 'mock-admin-token',
    );

    Go.offAll(const HomeScreen());
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
