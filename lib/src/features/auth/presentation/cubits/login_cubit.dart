part of '../imports/view_imports.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState.initial());

  static const String fakePassword = 'Password123!';

  Future<void> login(LoginParams params) async {
    if (!params.validate()) return;
    Go.offAll(const HomeScreen());
  }
}
