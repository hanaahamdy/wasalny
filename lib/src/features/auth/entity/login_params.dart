import 'package:flutter/material.dart';

class LoginParams {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String countryCode = '+966';

  bool validate() => formKey.currentState?.validate() ?? false;

  Map<String, dynamic> toJson() => {
    'login': phoneController.text.trim().isNotEmpty
        ? phoneController.text.trim()
        : emailController.text.trim(),
    if (phoneController.text.trim().isNotEmpty)
      'country_code': countryCode.replaceFirst('+', ''),
    'password': passwordController.text,
  };

  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
