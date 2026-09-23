import '../../../config/language/locale_keys.g.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/network_request.dart';
import '../../../core/network/network_service.dart';
import '../models/login_response_model.dart';

class AuthService {
  final NetworkService _networkService;

  const AuthService(this._networkService);

  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _networkService.callApi<LoginResponseModel>(
      NetworkRequest(
        method: RequestMethod.post,
        path: ApiConstants.login,
        body: {'email': email, 'password': password},
      ),
      mapper: (json) {
        final responseJson = Map<String, dynamic>.from(json as Map);
        final data = responseJson['data'];
        return LoginResponseModel.fromJson(
          data is Map ? Map<String, dynamic>.from(data) : <String, dynamic>{},
        );
      },
    );

    if (!response.data.isValid) {
      throw ServerException(LocaleKeys.exceptionError);
    }
    return response.data;
  }
}
