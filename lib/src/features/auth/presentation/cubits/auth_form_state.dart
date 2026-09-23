part of '../imports/view_imports.dart';

final class AuthFormState {
  final BaseStatus status;

  const AuthFormState({this.status = BaseStatus.initial});

  AuthFormState copyWith({BaseStatus? status}) {
    return AuthFormState(status: status ?? this.status);
  }
}
