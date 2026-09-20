import 'package:flutter/foundation.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../core/error/failure.dart';
import '../domain/repositories/employees_repository.dart';
import '../entity/employee_model.dart';

class EmployeeDetailsViewModel extends ChangeNotifier {
  final EmployeesRepository _repository;
  EmployeeModel employee;

  EmployeeDetailsViewModel(this._repository, this.employee);

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> load() async {
    final id = int.tryParse(employee.id);
    if (id == null) return;
    await _run<EmployeeModel>(
      () => _repository.fetchEmployee(id),
      (value) => employee = value,
    );
  }

  Future<EmployeeModel?> updateName(String name) async {
    final id = int.tryParse(employee.id);
    if (id == null) return null;
    EmployeeModel? updated;
    await _run<EmployeeModel>(() => _repository.updateEmployee(id, name), (value) {
      employee = value;
      updated = value;
    });
    return updated;
  }

  Future<bool> delete() async {
    final id = int.tryParse(employee.id);
    if (id == null) return false;
    var deleted = false;
    await _run<void>(() => _repository.deleteEmployee(id), (_) => deleted = true);
    return deleted;
  }

  void replace(EmployeeModel value) {
    employee = value;
    notifyListeners();
  }

  Future<void> _run<T>(
    Future<Result<T, Failure>> Function() request,
    void Function(T value) onSuccess,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    final result = await request();
    result.when(
      onSuccess,
      (failure) => _errorMessage = failure.message,
    );
    _isLoading = false;
    notifyListeners();
  }
}
