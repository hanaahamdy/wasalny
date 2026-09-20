import 'package:injectable/injectable.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/network_request.dart';
import '../../../../core/network/network_service.dart';
import '../../entity/create_employee_params.dart';

abstract interface class CreateEmployeeRemoteDataSource {
  Future<String> createEmployee(CreateEmployeeParams params);
}

@LazySingleton(as: CreateEmployeeRemoteDataSource)
class CreateEmployeeRemoteDataSourceImpl
    implements CreateEmployeeRemoteDataSource {
  final NetworkService _networkService;

  CreateEmployeeRemoteDataSourceImpl(this._networkService);

  @override
  Future<String> createEmployee(CreateEmployeeParams params) async {
    final response = await _networkService.callApi<String>(
      NetworkRequest(
        path: ApiConstants.register,
        method: RequestMethod.post,
        body: params.toJson(),
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
