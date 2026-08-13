import 'dart:io';

import 'package:flutter/material.dart';

import 'gender.dart';

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

  File? image;
  Gender? gender;
  String countryCode = '+966';
  String? cityId;
  String? districtId;
  double? latitude;
  double? longitude;

  bool validate() => formKey.currentState?.validate() ?? false;

  Map<String, dynamic> toJson() => {
    'name': fullNameController.text.trim(),
    'phone': phoneController.text.trim(),
    'country_code': countryCode,
    if (gender != null) 'gender': gender!.value,
    'birth_date': birthDateController.text.trim(),
    'password': passwordController.text,
    if (image != null) 'image': image,
    if (latitude != null) 'lat': latitude,
    if (longitude != null) 'lng': longitude,
    if (locationController.text.trim().isNotEmpty)
      'map_desc': locationController.text.trim(),
    if (cityId != null) 'city_id': cityId,
    if (districtId != null) 'district_id': districtId,
    if (emailController.text.trim().isNotEmpty)
      'email': emailController.text.trim(),
  };

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
