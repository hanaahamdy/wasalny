class AuthResponse {
  final String message;
  final AuthUserData? data;

  const AuthResponse({required this.message, this.data});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return AuthResponse(
      message: json['message']?.toString() ?? '',
      data: data is Map<String, dynamic> ? AuthUserData.fromJson(data) : null,
    );
  }
}

class AuthUserData {
  final String id;
  final String token;
  final String phone;

  const AuthUserData({
    required this.id,
    required this.token,
    required this.phone,
  });

  factory AuthUserData.fromJson(Map<String, dynamic> json) => AuthUserData(
    id: json['id']?.toString() ?? '',
    token: json['token']?.toString() ?? '',
    phone: json['phone']?.toString() ?? '',
  );
}
