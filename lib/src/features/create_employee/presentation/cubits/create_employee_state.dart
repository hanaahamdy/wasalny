import '../../../../core/shared/models/employee_type.dart';

final class CreateEmployeeState {
  final bool isLoading;
  final bool isSuccess;
  final EmployeeType? employeeType;
  final EmployeeCycle cycle;
  final String? errorMessage;
  final String? successMessage;

  const CreateEmployeeState({
    this.isLoading = false,
    this.isSuccess = false,
    this.employeeType,
    this.cycle = EmployeeCycle.cycleOne,
    this.errorMessage,
    this.successMessage,
  });

  CreateEmployeeState copyWith({
    bool? isLoading,
    bool? isSuccess,
    EmployeeType? employeeType,
    EmployeeCycle? cycle,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) => CreateEmployeeState(
    isLoading: isLoading ?? this.isLoading,
    isSuccess: isSuccess ?? this.isSuccess,
    employeeType: employeeType ?? this.employeeType,
    cycle: cycle ?? this.cycle,
    errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    successMessage: clearSuccess ? null : successMessage ?? this.successMessage,
  );
}
