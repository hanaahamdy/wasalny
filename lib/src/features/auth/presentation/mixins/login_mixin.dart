part of '../imports/view_imports.dart';

mixin LoginMixin on Cubit<AuthFormState> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    if (state.isLoading) return;
    _loginAsAdmin();
  }

  Future<void> _loginAsAdmin() async {
    emit(state.copyWith(isLoading: true));
    final adminUser = UserModel.initial().copyWith(
      fullName: 'Admin',
      phoneNumber: phoneController.text.trim(),
      userType: UserType.admin,
    );

    await UserCubit.instance.setUserLoggedIn(
      user: adminUser,
      token: 'mock-admin-token',
    );

    Go.offAll(const HomeScreen());
  }

  void createDeliveryAccount() {
    Go.off(const RegisterScreen());
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
