import 'package:flutter/material.dart';

class SignUpParams {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String type = 'لاعب';
  String gender = 'ذكر';
  String? city;
  String? district;
  bool acceptedTerms = false;

  bool validate() => formKey.currentState?.validate() ?? false;

  void dispose() {
    phoneController.dispose();
    fullNameController.dispose();
    birthDateController.dispose();
    emailController.dispose();
    locationController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
