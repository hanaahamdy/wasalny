enum UserType {
  delivery('delivery'),
  admin('admin'),
  buyer('buyer'),
  packing('packing'),
  aliaa('aliaa');

  final String value;

  const UserType(this.value);

  static UserType fromJson(dynamic value) {
    final rawValue = value is Map ? value['value'] : value;
    final normalizedValue = rawValue?.toString().trim().toLowerCase();

    return switch (normalizedValue) {
      'admin' || '1' => UserType.admin,
      'delivery' || 'driver' || '0' => UserType.delivery,
      'buyer' => UserType.buyer,
      'packing' => UserType.packing,
      'aliaa' => UserType.aliaa,
      _ => UserType.delivery,
    };
  }
}

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
  final String address;
  final double? latitude;
  final double? longitude;
  final String systemType;
  final bool isActive;
  final String createdAt;
  final String updatedAt;
  final UserType userType;
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
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.systemType,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
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
    address: '',
    latitude: null,
    longitude: null,
    systemType: '',
    isActive: false,
    createdAt: '',
    updatedAt: '',
    userType: UserType.delivery,
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
    String? address,
    double? latitude,
    double? longitude,
    String? systemType,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
    UserType? userType,
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
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      systemType: systemType ?? this.systemType,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    final userTypeData =
        json['userType'] ?? json['user_type'] ?? json['role'] ?? typeData;

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
      address: json['address']?.toString() ?? '',
      latitude: _toDouble(json['latitude']),
      longitude: _toDouble(json['longitude']),
      systemType: (json['systemType'] ?? json['system_type'])?.toString() ?? '',
      isActive: _toBool(json['isActive'] ?? json['is_active']),
      createdAt: (json['createdAt'] ?? json['created_at'])?.toString() ?? '',
      updatedAt: (json['updatedAt'] ?? json['updated_at'])?.toString() ?? '',
      userType: UserType.fromJson(userTypeData),
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
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
    'systemType': systemType,
    'isActive': isActive,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'userType': userType.value,
    'allowNotify': allowNotify,
  };

  static double? _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '');
  }

  static bool _toBool(dynamic value) {
    return value == true || value == 1 || value?.toString() == '1';
  }
}
