import '../../../core/shared/models/user_model.dart';

class LoginResponseModel {
  final UserModel user;
  final String accessToken;

  const LoginResponseModel({required this.user, required this.accessToken});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'];
    return LoginResponseModel(
      user: UserModel.fromJson(
        userJson is Map
            ? Map<String, dynamic>.from(userJson)
            : <String, dynamic>{},
      ),
      accessToken: json['access_token']?.toString().trim() ?? '',
    );
  }

  bool get isValid => user.id.isNotEmpty && accessToken.isNotEmpty;
}
