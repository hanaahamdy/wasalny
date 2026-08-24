part of '../imports/view_imports.dart';

final class AuthFormState {
  final bool isLoading;

  const AuthFormState({this.isLoading = false});

  AuthFormState copyWith({bool? isLoading}) {
    return AuthFormState(isLoading: isLoading ?? this.isLoading);
  }
}
