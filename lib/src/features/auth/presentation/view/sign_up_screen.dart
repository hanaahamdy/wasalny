part of '../imports/view_imports.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => CitiesCubit()..fetchInitialData()),
        BlocProvider(create: (context) => DistrictsCubit()),
      ],
      child: const Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: SafeArea(child: _SignUpBody()),
      ),
    );
  }
}
