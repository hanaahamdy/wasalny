part of '../imports/view_imports.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(),
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: AppColors.scaffoldBackground,
        body: const SafeArea(child: _ResetPasswordBody()),
      ),
    );
  }
}
