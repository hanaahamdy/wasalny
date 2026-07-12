part of '../imports/view_imports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: SafeArea(child: _LoginBody()),
      ),
    );
  }
}
