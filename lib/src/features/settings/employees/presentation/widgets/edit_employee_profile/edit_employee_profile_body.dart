part of '../../imports/presentation_imports.dart';

class EditEmployeeProfileBody extends StatefulWidget {
  final EmployeeDetailsViewModel viewModel;

  const EditEmployeeProfileBody({super.key, required this.viewModel});

  @override
  State<EditEmployeeProfileBody> createState() =>
      _EditEmployeeProfileBodyState();
}

class _EditEmployeeProfileBodyState extends State<EditEmployeeProfileBody> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.viewModel.employee.name,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW10,
        vertical: AppPadding.pH12,
      ),
      child: Column(
        children: [
          EditEmployeeTextField(
            label: LocaleKeys.name,
            controller: _nameController,
            icon: Icons.person_outline,
            keyboardType: TextInputType.name,
          ),
          SizedBox(height: AppSize.sH12),
          SizedBox(height: AppSize.sH16),
          DefaultButton(
            width: double.infinity,
            height: AppSize.sH45,
            title: LocaleKeys.saveChanges,
            onTap: widget.viewModel.isLoading
                ? null
                : () async {
                    final updated = await widget.viewModel.updateName(
                      _nameController.text.trim(),
                    );
                    if (updated != null) Go.back(updated);
                  },
          ),
        ],
      ),
    );
  }
}
