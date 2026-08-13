class UserModel {
  final String id;
  final String image;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String city;
  final String district;
  final String gender;
  final String birthDate;
  final String location;
  final int userType;
  final bool allowNotify;
  final String? token;

  UserModel({
    required this.id,
    required this.image,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.city,
    required this.district,
    required this.gender,
    required this.birthDate,
    required this.location,
    required this.userType,
    required this.allowNotify,
    required this.token,
  });

  factory UserModel.initial() => UserModel(
    id: '',
    image: '',
    fullName: '',
    phoneNumber: '',
    email: '',
    city: '',
    district: '',
    gender: '',
    birthDate: '',
    location: '',
    userType: 0,
    allowNotify: false,
    token: '',
  );

  UserModel copyWith({
    String? id,
    String? image,
    String? fullName,
    String? phoneNumber,
    String? email,
    String? city,
    String? district,
    String? gender,
    String? birthDate,
    String? location,
    int? userType,
    bool? allowNotify,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      image: image ?? this.image,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      city: city ?? this.city,
      district: district ?? this.district,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      location: location ?? this.location,
      userType: userType ?? this.userType,
      allowNotify: allowNotify ?? this.allowNotify,
      token: token ?? this.token,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final cityData = json['city'];
    final districtData = json['district'];
    final genderData = json['gender'];
    final locationData = json['location'];
    final typeData = json['type'];
    final legacyUserType = json['userType'];

    return UserModel(
      id: json['id']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      fullName: (json['fullName'] ?? json['name'])?.toString() ?? '',
      phoneNumber: (json['phoneNumber'] ?? json['phone'])?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      city: cityData is Map
          ? cityData['name']?.toString() ?? ''
          : cityData?.toString() ?? '',
      district: districtData is Map
          ? districtData['name']?.toString() ?? ''
          : districtData?.toString() ?? '',
      gender: genderData is Map
          ? (genderData['label'] ?? genderData['value'])?.toString() ?? ''
          : genderData?.toString() ?? '',
      birthDate: (json['birthDate'] ?? json['birth_date'])?.toString() ?? '',
      location: locationData is Map
          ? locationData['map_desc']?.toString() ?? ''
          : locationData?.toString() ?? '',
      userType: legacyUserType is int
          ? legacyUserType
          : typeData is Map && typeData['value'] == 'player'
          ? 1
          : 0,
      allowNotify: (json['allowNotify'] ?? json['is_notify']) == true,
      token: json['token']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'fullName': fullName,
    'phoneNumber': phoneNumber,
    'email': email,
    'city': city,
    'district': district,
    'gender': gender,
    'birthDate': birthDate,
    'location': location,
    'userType': userType,
    'allowNotify': allowNotify,
  };
}
