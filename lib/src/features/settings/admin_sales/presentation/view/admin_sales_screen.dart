part of '../imports/presentation_imports.dart';

class AdminSalesScreen extends StatelessWidget {
  const AdminSalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.sales),
        flexibleSpace: DecoratedBox(
          decoration: BoxDecoration(gradient: AppColors.scenarioGradient),
        ),
        actions: [
          IconButton(
            tooltip: LocaleKeys.salesFilter,
            onPressed: () => AdminSalesFilterSheet.show(context),
            icon: const Icon(Icons.filter_alt_outlined),
          ),
        ],
      ),
      body: const AdminSalesBody(),
    );
  }
}
