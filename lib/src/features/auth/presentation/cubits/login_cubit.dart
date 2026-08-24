part of '../imports/view_imports.dart';

class LoginCubit extends Cubit<AuthFormState> with LoginMixin {
  LoginCubit() : super(const AuthFormState());
}
