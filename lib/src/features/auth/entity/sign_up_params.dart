import 'dart:io';

import 'package:flutter/material.dart';

import '../../../config/language/locale_keys.g.dart';

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

  String type = LocaleKeys.signUpPlayer;
  String gender = LocaleKeys.signUpMale;
  String? city;
  String? district;
  final ValueNotifier<File?> avatarImageNotifier = ValueNotifier<File?>(null);
  final ValueNotifier<bool> acceptedTermsNotifier = ValueNotifier<bool>(false);

  List<String> get genderOptions => [
    LocaleKeys.signUpMale,
    LocaleKeys.signUpFemale,
  ];

  List<String> get fullNameOptions => [
    LocaleKeys.signUpNewPlayer,
    LocaleKeys.signUpTeamMember,
  ];

  List<String> get birthDateOptions => [
    LocaleKeys.signUpAgeUnder18,
    LocaleKeys.signUpAge18To25,
    LocaleKeys.signUpAge26To35,
    LocaleKeys.signUpAgeOver35,
  ];

  List<String> get cityOptions => ['Riyadh', 'Jeddah', 'Cairo'];

  List<String> get districtOptions => [
    'Al Nakheel District',
    'Al Faisaliah District',
    'Al Malqa District',
    'Nasr City',
  ];

  bool validate() => formKey.currentState?.validate() ?? false;

  void dispose() {
    phoneController.dispose();
    fullNameController.dispose();
    birthDateController.dispose();
    emailController.dispose();
    locationController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    avatarImageNotifier.dispose();
    acceptedTermsNotifier.dispose();
  }
}
