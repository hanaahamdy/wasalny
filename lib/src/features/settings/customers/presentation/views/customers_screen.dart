part of '../imports/presentation_imports.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.customers)),
      body: const CustomersBody(),
    );
  }
}
