part of '../imports/view_imports.dart';

class ChangePasswordScreen extends StatelessWidget {
  final String phone;
  final String verificationCode;

  const ChangePasswordScreen({
    super.key,
    required this.phone,
    required this.verificationCode,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChangePasswordCubit(),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: SafeArea(
          child: _ChangePasswordBody(
            phone: phone,
            verificationCode: verificationCode,
          ),
        ),
      ),
    );
  }
}
