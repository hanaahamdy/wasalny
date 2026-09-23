import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/network_request.dart';
import '../../../../core/network/network_service.dart';
import '../models/home_model.dart';

class HomeService {
  final NetworkService _networkService;

  const HomeService(this._networkService);

  Future<HomeModel> fetchHome() async {
    final response = await _networkService.callApi<HomeModel>(
      NetworkRequest(method: RequestMethod.get, path: ApiConstants.home),
      mapper: (json) {
        final responseJson = Map<String, dynamic>.from(json as Map);
        final data = responseJson['data'];
        return HomeModel.fromJson(
          data is Map ? Map<String, dynamic>.from(data) : <String, dynamic>{},
        );
      },
    );
    return response.data;
  }
}
