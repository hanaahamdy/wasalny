part of '../../imports/view_imports.dart';

class LoginCubit extends Cubit<LoginState> with LoginMixin {
  final AuthRepository _repository;

  LoginCubit({AuthRepository? repository})
    : _repository = repository ?? injector<AuthRepository>(),
      super(const LoginState());

  Future<Result<UserModel, Failure>> requestLogin(LoginParams params) {
    return _repository.login(params);
  }

  Future<void> login() async {
    if (state.isLoading || formKey.currentState?.validate() != true) return;

    emit(state.copyWith(isLoading: true, isSuccess: false, clearError: true));
    final result = await requestLogin(
      LoginParams(
        email: emailController.text.trim(),
        password: passwordController.text,
      ),
    );

    await result.when(
      (user) async {
        final token = user.accessToken?.trim();
        if (token == null || token.isEmpty) {
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: LocaleKeys.serverError,
            ),
          );
          return;
        }
        await UserCubit.instance.setUserLoggedIn(user: user, token: token);
        emit(state.copyWith(isLoading: false, isSuccess: true));
      },
      (failure) async {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
    );
  }
}
