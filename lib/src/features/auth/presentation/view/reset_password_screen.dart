part of '../imports/view_imports.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(backgroundColor:   AppColors.scaffoldBackground,),
      backgroundColor: AppColors.scaffoldBackground,
      body: const SafeArea(child: _ResetPasswordBody()),
    );
  }
}
