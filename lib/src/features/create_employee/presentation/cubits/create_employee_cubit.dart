part of '../imports/presentation_imports.dart';

class CreateEmployeeCubit extends Cubit<CreateEmployeeState>
    with CreateEmployeeControllers {
  final CreateEmployeeRepository _repository;

  CreateEmployeeCubit({CreateEmployeeRepository? repository})
    : _repository = repository ?? injector<CreateEmployeeRepository>(),
      super(const CreateEmployeeState());

  void selectEmployeeType(EmployeeType? employeeType) {
    if (employeeType == null) return;
    emit(state.copyWith(employeeType: employeeType));
  }

  void selectCycle(EmployeeCycle? cycle) {
    if (cycle == null) return;
    emit(state.copyWith(cycle: cycle));
  }

  Future<void> createEmployee() async {
    if (state.isLoading || formKey.currentState?.validate() != true) return;
    emit(
      state.copyWith(
        isLoading: true,
        isSuccess: false,
        clearError: true,
        clearSuccess: true,
      ),
    );
    final result = await _repository.createEmployee(
      CreateEmployeeParams(
        name: fullNameController.text.trim(),
        phone: phoneController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        employeeType: state.employeeType!,
        cycle: state.cycle,
      ),
    );
    result.when(
      (message) => emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          successMessage: message,
        ),
      ),
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
    );
  }
}
