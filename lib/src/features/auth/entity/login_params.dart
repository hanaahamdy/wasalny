import 'package:flutter/material.dart';

class LoginParams {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool validate() => formKey.currentState?.validate() ?? false;

  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
  }
}
