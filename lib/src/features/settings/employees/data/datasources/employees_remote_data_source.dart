import 'package:injectable/injectable.dart';

import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/network/network_request.dart';
import '../../../../../core/network/network_service.dart';
import '../../../../../core/shared/models/employee_type.dart';
import '../../entity/employee_model.dart';

abstract interface class EmployeesRemoteDataSource {
  Future<List<EmployeeModel>> fetchEmployees(EmployeeType type);
  Future<EmployeeModel> fetchEmployee(int id);
  Future<EmployeeModel> updateEmployee(int id, String name);
  Future<void> deleteEmployee(int id);
}

@LazySingleton(as: EmployeesRemoteDataSource)
class EmployeesRemoteDataSourceImpl implements EmployeesRemoteDataSource {
  final NetworkService _networkService;

  EmployeesRemoteDataSourceImpl(this._networkService);

  @override
  Future<List<EmployeeModel>> fetchEmployees(EmployeeType type) async {
    final response = await _networkService.callApi<List<EmployeeModel>>(
      NetworkRequest(
        path: ApiConstants.employees,
        method: RequestMethod.get,
        queryParameters: {'role': type.apiValue},
      ),
      mapper: (json) {
        final data = _responseData(json);
        final items = data is List
            ? data
            : data is Map && data['data'] is List
            ? data['data'] as List
            : const [];
        return items
            .whereType<Map>()
            .map(
              (item) => EmployeeModel.fromJson(Map<String, dynamic>.from(item)),
            )
            .toList();
      },
    );
    return response.data;
  }

  @override
  Future<EmployeeModel> fetchEmployee(int id) async {
    final response = await _networkService.callApi<EmployeeModel>(
      NetworkRequest(
        path: ApiConstants.employeeDetails(id),
        method: RequestMethod.get,
      ),
      mapper: (json) => EmployeeModel.fromJson(
        Map<String, dynamic>.from(_responseData(json) as Map),
      ),
    );
    return response.data;
  }

  @override
  Future<EmployeeModel> updateEmployee(int id, String name) async {
    final response = await _networkService.callApi<EmployeeModel>(
      NetworkRequest(
        path: ApiConstants.employeeDetails(id),
        method: RequestMethod.patch,
        body: {'name': name},
        isFormData: true,
      ),
      mapper: (json) => EmployeeModel.fromJson(
        Map<String, dynamic>.from(_responseData(json) as Map),
      ),
    );
    return response.data;
  }

  @override
  Future<void> deleteEmployee(int id) async {
    await _networkService.callApi<dynamic>(
      NetworkRequest(
        path: ApiConstants.employeeDetails(id),
        method: RequestMethod.delete,
      ),
    );
  }

  dynamic _responseData(dynamic json) => json is Map ? json['data'] : null;
}
