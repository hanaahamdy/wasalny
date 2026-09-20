import 'package:flutter/foundation.dart';

import '../../../../core/shared/models/employee_type.dart';
import '../domain/repositories/employees_repository.dart';
import '../entity/employee_model.dart';

class EmployeesViewModel extends ChangeNotifier {
  final EmployeesRepository _repository;
  final EmployeeType employeeType;

  EmployeesViewModel(this._repository, this.employeeType);

  List<EmployeeModel> _employees = const [];
  String _query = '';
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<EmployeeModel> get employees =>
      _employees.where(_matchesSearch).toList();

  Future<void> load() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    final result = await _repository.fetchEmployees(employeeType);
    result.when(
      (employees) => _employees = employees,
      (failure) => _errorMessage = failure.message,
    );
    _isLoading = false;
    notifyListeners();
  }

  void search(String value) {
    _query = value.trim().toLowerCase();
    notifyListeners();
  }

  bool _matchesSearch(EmployeeModel employee) =>
      _query.isEmpty ||
      employee.name.toLowerCase().contains(_query) ||
      employee.phone.contains(_query) ||
      employee.email.toLowerCase().contains(_query) ||
      employee.id.toLowerCase().contains(_query);
}
