import 'dart:io';

class UpdateProfileParams {
  final String fullName;
  final String birthDate;
  final String email;
  final String location;
  final String gender;
  final int? cityId;
  final int? districtId;
  final String? cityName;
  final String? districtName;
  final File? image;

  const UpdateProfileParams({
    required this.fullName,
    required this.birthDate,
    required this.email,
    required this.location,
    required this.gender,
    this.cityId,
    this.districtId,
    this.cityName,
    this.districtName,
    this.image,
  });

  Map<String, dynamic> toJson() => {
    '_method': 'PUT',
    'name': fullName,
    'birth_date': birthDate,
    if (email.isNotEmpty) 'email': email,
    'gender': gender,
    if (location.isNotEmpty) 'map_desc': location,
    if (cityId != null) 'city_id': cityId,
    if (districtId != null) 'district_id': districtId,
    'image': ?image,
  };
}
