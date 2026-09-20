part of '../imports/presentation_imports.dart';

class EditEmployeeProfileScreen extends StatefulWidget {
  final EmployeeModel employee;

  const EditEmployeeProfileScreen({super.key, required this.employee});

  @override
  State<EditEmployeeProfileScreen> createState() =>
      _EditEmployeeProfileScreenState();
}

class _EditEmployeeProfileScreenState extends State<EditEmployeeProfileScreen> {
  late final EmployeeDetailsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = EmployeeDetailsViewModel(
      injector<EmployeesRepository>(),
      widget.employee,
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.editEmployeeProfile),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (_, _) => EditEmployeeProfileBody(viewModel: _viewModel),
      ),
    );
  }
}
