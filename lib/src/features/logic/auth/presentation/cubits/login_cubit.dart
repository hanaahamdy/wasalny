part of '../imports/view_imports.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial());

  static const String fakePassword = 'Password123!';

  Future<void> login(LoginParams params) async {
    if (!params.validate()) return;

    emit(state.loading());
    await Future<void>.delayed(const Duration(milliseconds: 650));

    final phone = params.phoneController.text.trim();
    final password = params.passwordController.text;

    if (_isValidFakeUser(phone: phone, password: password)) {
      emit(state.success(LocaleKeys.goodToSee));
    } else {
      emit(state.error(LocaleKeys.incorrectEmailOrPassword));
    }
  }

  bool _isValidFakeUser({required String phone, required String password}) {
    return phone.length >= 8 && password == fakePassword;
  }
}
