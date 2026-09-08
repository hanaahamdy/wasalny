import 'package:injectable/injectable.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/network_request.dart';
import '../../../../core/network/network_service.dart';
import '../../../../core/shared/models/user_model.dart';
import '../../entity/login_params.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> login(LoginParams params);
  Future<String> forgotPassword(String email);
  Future<String> resetPassword({
    required String email,
    required String otp,
    required String password,
  });
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final NetworkService _networkService;

  AuthRemoteDataSourceImpl(this._networkService);

  @override
  Future<UserModel> login(LoginParams params) async {
    final response = await _networkService.callApi<UserModel>(
      NetworkRequest(
        path: ApiConstants.login,
        method: RequestMethod.post,
        body: params.toJson(),
        isFormData: true,
      ),
      mapper: (json) {
        final responseJson = Map<String, dynamic>.from(json as Map);
        final data = responseJson['data'];
        if (data is! Map) {
          throw const FormatException('Invalid login response');
        }
        final dataMap = Map<String, dynamic>.from(data);
        final userJson = dataMap['user'] is Map
            ? Map<String, dynamic>.from(dataMap['user'] as Map)
            : dataMap;
        final token =
            userJson['token'] ?? dataMap['access_token'] ?? dataMap['token'];
        return UserModel.fromJson({...userJson, 'access_token': token});
      },
    );
    return response.data;
  }

  @override
  Future<String> forgotPassword(String email) =>
      _postMessage(path: ApiConstants.forgotPassword, body: {'email': email});

  @override
  Future<String> resetPassword({
    required String email,
    required String otp,
    required String password,
  }) => _postMessage(
    path: ApiConstants.resetPassword,
    body: {'email': email, 'otp': otp, 'password': password},
  );

  Future<String> _postMessage({
    required String path,
    required Map<String, dynamic> body,
  }) async {
    final response = await _networkService.callApi<String>(
      NetworkRequest(
        path: path,
        method: RequestMethod.post,
        body: body,
        isFormData: true,
      ),
      mapper: (json) {
        final responseJson = Map<String, dynamic>.from(json as Map);
        return responseJson['message']?.toString() ?? '';
      },
    );
    return response.data;
  }
}
