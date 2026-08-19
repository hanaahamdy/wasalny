part of '../imports/view_imports.dart';

class ResetPasswordScreen extends StatelessWidget {
  final bool byEmail;

  const ResetPasswordScreen({super.key, this.byEmail = false});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(),
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: AppColors.scaffoldBackground,
        body: SafeArea(child: _ResetPasswordBody(byEmail: byEmail)),
      ),
    );
  }
}
