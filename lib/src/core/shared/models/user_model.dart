enum UserRole {
  delivery('delivery'),
  admin('admin'),
  buyer('buyer'),
  packing('packing'),
  aliaa('alia');

  final String value;

  const UserRole(this.value);

  String toJson() => value;

  static UserRole fromJson(dynamic value) {
    final normalizedValue = value?.toString().trim().toLowerCase();
    return switch (normalizedValue) {
      'admin' => UserRole.admin,
      'delivery' => UserRole.delivery,
      'buyer' || 'supervisor' => UserRole.buyer,
      'picking' || 'packing' || 'packin' => UserRole.packing,
      'alia' || 'aliaa' || 'sales' => UserRole.aliaa,
      _ => UserRole.delivery,
    };
  }
}

class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final UserRole role;
  final String? profilePhotoPath;
  final String? address;
  final String? image;
  final double? latitude;
  final double? longitude;
  final int isActive;
  final String? lastSeenAt;
  final String? passwordResetOtp;
  final String? passwordResetOtpExpiresAt;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String systemType;
  final String? accessToken;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.profilePhotoPath,
    this.address,
    this.image,
    this.latitude,
    this.longitude,
    required this.isActive,
    this.lastSeenAt,
    this.passwordResetOtp,
    this.passwordResetOtpExpiresAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.systemType,
    this.accessToken,
  });

  factory UserModel.initial() => const UserModel(
    id: 0,
    name: '',
    email: '',
    phone: '',
    role: UserRole.delivery,
    isActive: 0,
    systemType: '',
  );

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    UserRole? role,
    String? profilePhotoPath,
    String? address,
    String? image,
    double? latitude,
    double? longitude,
    int? isActive,
    String? lastSeenAt,
    String? passwordResetOtp,
    String? passwordResetOtpExpiresAt,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? systemType,
    String? accessToken,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      profilePhotoPath: profilePhotoPath ?? this.profilePhotoPath,
      address: address ?? this.address,
      image: image ?? this.image,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isActive: isActive ?? this.isActive,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      passwordResetOtp: passwordResetOtp ?? this.passwordResetOtp,
      passwordResetOtpExpiresAt:
          passwordResetOtpExpiresAt ?? this.passwordResetOtpExpiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      systemType: systemType ?? this.systemType,
      accessToken: accessToken ?? this.accessToken,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    double? asDouble(dynamic value) => value is num
        ? value.toDouble()
        : double.tryParse(value?.toString() ?? '');

    int asInt(dynamic value) =>
        value is num ? value.toInt() : int.tryParse('$value') ?? 0;

    return UserModel(
      id: asInt(json['id']),
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      role: UserRole.fromJson(json['role']),
      profilePhotoPath: json['profile_photo_path']?.toString(),
      address: json['address']?.toString(),
      image: json['image']?.toString(),
      latitude: asDouble(json['latitude']),
      longitude: asDouble(json['longitude']),
      isActive: asInt(json['is_active']),
      lastSeenAt: json['last_seen_at']?.toString(),
      passwordResetOtp: json['password_reset_otp']?.toString(),
      passwordResetOtpExpiresAt: json['password_reset_otp_expires_at']
          ?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      deletedAt: json['deleted_at']?.toString(),
      systemType: json['system_type']?.toString() ?? '',
      accessToken: json['access_token']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'role': role.toJson(),
    'profile_photo_path': profilePhotoPath,
    'address': address,
    'image': image,
    'latitude': latitude,
    'longitude': longitude,
    'is_active': isActive,
    'last_seen_at': lastSeenAt,
    'password_reset_otp': passwordResetOtp,
    'password_reset_otp_expires_at': passwordResetOtpExpiresAt,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'deleted_at': deletedAt,
    'system_type': systemType,
    'access_token': accessToken,
  };
}
