part of '../imports/presentation_imports.dart';

class EmployeesScreen extends StatefulWidget {
  final EmployeeType employeeType;

  const EmployeesScreen({super.key, required this.employeeType});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  late final EmployeesViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = EmployeesViewModel(
      injector<EmployeesRepository>(),
      widget.employeeType,
    )..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: _employeeTypeLabel(widget.employeeType)),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (_, _) => EmployeesBody(viewModel: _viewModel),
      ),
    );
  }

  String _employeeTypeLabel(EmployeeType type) => switch (type) {
    EmployeeType.delivery => LocaleKeys.employeeDelivery,
    EmployeeType.buyer => LocaleKeys.employeeBuyer,
    EmployeeType.packer => LocaleKeys.employeePacker,
    EmployeeType.alia => LocaleKeys.employeeAliaa,
  };
}
