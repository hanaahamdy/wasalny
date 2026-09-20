part of '../imports/presentation_imports.dart';

class CreateEmployeeScreen extends StatelessWidget {
  const CreateEmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateEmployeeCubit(),
      child: Scaffold(
        appBar: CustomAppBar(title: LocaleKeys.addEmployee),
        body: const CreateEmployeeBody(),
      ),
    );
  }
}
