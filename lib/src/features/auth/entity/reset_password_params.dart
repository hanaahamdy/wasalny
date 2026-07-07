import 'package:flutter/material.dart';

class ResetPasswordParams {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool validate() => formKey.currentState?.validate() ?? false;

  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
