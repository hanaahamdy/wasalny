part of '../imports/presentation_imports.dart';

class EmployeeTypeScreen extends StatelessWidget {
  const EmployeeTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.selectEmployeeType),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pW12,
          vertical: AppPadding.pH14,
        ),
        itemCount: EmployeeType.values.length,
        separatorBuilder: (_, _) => SizedBox(height: AppSize.sH10),
        itemBuilder: (_, index) {
          final type = EmployeeType.values[index];
          return EmployeeTypeCard(
            title: _label(type),
            icon: _icon(type),
            onTap: () => Go.to(EmployeesScreen(employeeType: type)),
          );
        },
      ),
    );
  }

  String _label(EmployeeType type) => switch (type) {
    EmployeeType.delivery => LocaleKeys.employeeDelivery,
    EmployeeType.buyer => LocaleKeys.employeeBuyer,
    EmployeeType.packer => LocaleKeys.employeePacker,
    EmployeeType.alia => LocaleKeys.employeeAliaa,
  };

  IconData _icon(EmployeeType type) => switch (type) {
    EmployeeType.delivery => Icons.local_shipping_outlined,
    EmployeeType.buyer => Icons.shopping_bag_outlined,
    EmployeeType.packer => Icons.inventory_2_outlined,
    EmployeeType.alia => Icons.assignment_ind_outlined,
  };
}
