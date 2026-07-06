part of '../imports/view_imports.dart';

final class LoginState extends Equatable {
  final BaseStatus status;
  final String? message;

  const LoginState({this.status = BaseStatus.initial, this.message});

  factory LoginState.initial() => const LoginState();

  LoginState loading() => const LoginState(status: BaseStatus.loading);

  LoginState success(String message) =>
      LoginState(status: BaseStatus.success, message: message);

  LoginState error(String message) =>
      LoginState(status: BaseStatus.error, message: message);

  @override
  List<Object?> get props => [status, message];
}
