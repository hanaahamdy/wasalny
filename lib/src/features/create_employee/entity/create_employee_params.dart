import '../../../core/shared/models/employee_type.dart';

class CreateEmployeeParams {
  final String name;
  final String phone;
  final String email;
  final String password;
  final EmployeeType employeeType;
  final EmployeeCycle cycle;

  const CreateEmployeeParams({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.employeeType,
    required this.cycle,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'email': email,
    'password': password,
    'password_confirmation': password,
    'role': employeeType.apiValue,
    'system_type': cycle == EmployeeCycle.cycleOne
        ? 'system_one'
        : 'system_two',
  };
}
