part of '../imports/view_imports.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: AppColors.scaffoldBackground,
        body: const SafeArea(child: _SignUpBody()),
      ),
    );
  }
}
