part of '../imports/view_imports.dart';

class RegisterCubit extends Cubit<AuthFormState> with RegisterMixin {
  RegisterCubit() : super(const AuthFormState());
}
