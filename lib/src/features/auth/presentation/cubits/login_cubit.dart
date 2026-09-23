part of '../imports/view_imports.dart';

class LoginCubit extends Cubit<AuthFormState> {
  LoginCubit({AuthService? authService})
    : _authService = authService ?? AuthService(injector<NetworkService>()),
      super(const AuthFormState());

  final AuthService _authService;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    if (state.status.isLoading) return;
    if (formKey.currentState?.validate() != true) return;

    emit(state.copyWith(status: BaseStatus.loading));
    final result = await _authService
        .login(
          email: emailController.text.trim(),
          password: passwordController.text,
        )
        .handleCallbackWithFailure();

    await result.when((loginResponse) async {
      final user = loginResponse.user;
      await UserCubit.instance.setUserLoggedIn(
        user: user,
        token: loginResponse.accessToken,
      );
      _applySystemType(user.systemType);
      emit(state.copyWith(status: BaseStatus.success));
      navigateToRoleCycle(user.userType);
    }, (failure) async => _showError(failure.message));
  }

  void navigateToRoleCycle(UserType userType) {
    switch (userType) {
      case UserType.admin:
      case UserType.delivery:
        Go.offAll(const HomeScreen());
      case UserType.buyer:
        Go.offAll(const BuyerScreen());
      case UserType.packing:
        Go.offAll(const PackingScreen());
      case UserType.aliaa:
        Go.offAll(const AliaaScreen());
    }
  }

  void _applySystemType(String systemType) {
    AppColors.selectedScenario = systemType.trim().toLowerCase() == 'system_two'
        ? AppColorScenario.second
        : AppColorScenario.first;
    SystemChrome.setSystemUIOverlayStyle(AppColors.systemUiOverlayStyle);
  }

  void _showError(String message) {
    emit(state.copyWith(status: BaseStatus.error));
    MessageUtils.showSnackBar(baseStatus: BaseStatus.error, message: message);
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
