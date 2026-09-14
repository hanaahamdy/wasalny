part of '../imports/presentation_imports.dart';

class AdminSalesScreen extends StatelessWidget {
  const AdminSalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.sales,
        actions: [
          IconButton(
            tooltip: LocaleKeys.filter,
            onPressed: () => AdminSalesFilterSheet.show(context),
            icon: const Icon(Icons.filter_alt_outlined),
          ),
        ],
      ),
      body: const AdminSalesBody(),
    );
  }
}
