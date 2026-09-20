part of '../imports/presentation_imports.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  final EmployeeModel employee;

  const EmployeeDetailsScreen({super.key, required this.employee});

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  late final EmployeeDetailsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = EmployeeDetailsViewModel(
      injector<EmployeesRepository>(),
      widget.employee,
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
      appBar: CustomAppBar(title: LocaleKeys.employeeDetails),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (_, _) => EmployeeDetailsBody(viewModel: _viewModel),
      ),
    );
  }
}
