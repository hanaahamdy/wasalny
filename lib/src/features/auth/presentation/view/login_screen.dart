part of '../imports/view_imports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isSuccess || state.status.isError) {
            MessageUtils.showSnackBar(
              context: context,
              baseStatus: state.status,
              message: state.message ?? ConstantManager.emptyText,
            );
          }
        },
        child: const Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: SafeArea(child: _LoginBody()),
        ),
      ),
    );
  }
}
