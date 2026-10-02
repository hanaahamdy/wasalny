part of '../../imports/presentation_imports.dart';

class EditEmployeeProfileBody extends StatefulWidget {
  final EmployeeDetailsViewModel viewModel;

  const EditEmployeeProfileBody({super.key, required this.viewModel});

  @override
  State<EditEmployeeProfileBody> createState() =>
      _EditEmployeeProfileBodyState();
}

class _EditEmployeeProfileBodyState extends State<EditEmployeeProfileBody> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.viewModel.employee.name,
    );
    _emailController = TextEditingController(
      text: widget.viewModel.employee.email,
    );
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW10,
        vertical: AppPadding.pH12,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            EditEmployeeTextField(
              label: LocaleKeys.name,
              controller: _nameController,
              icon: Icons.person_outline,
              keyboardType: TextInputType.name,
              validator: (value) =>
                  Validators.validateName(value, fieldTitle: LocaleKeys.name),
            ),
            SizedBox(height: AppSize.sH12),
            EditEmployeeTextField(
              label: LocaleKeys.email,
              controller: _emailController,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) =>
                  Validators.validateEmail(value, fieldTitle: LocaleKeys.email),
            ),
            SizedBox(height: AppSize.sH12),
            EditEmployeeTextField(
              label: LocaleKeys.password,
              controller: _passwordController,
              icon: Icons.lock_outline,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              textInputAction: TextInputAction.done,
              validator: (value) => Validators.validatePassword(
                value,
                fieldTitle: LocaleKeys.password,
              ),
            ),
            SizedBox(height: AppSize.sH16),
            DefaultButton(
              width: double.infinity,
              height: AppSize.sH45,
              title: LocaleKeys.saveChanges,
              onTap: widget.viewModel.isLoading ? null : _save,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final updated = await widget.viewModel.updateProfile(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
    if (mounted && updated != null) Go.back(updated);
  }
}
