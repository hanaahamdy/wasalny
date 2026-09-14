part of '../imports/presentation_imports.dart';

class AdminHomeActions extends StatelessWidget {
  const AdminHomeActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _AdminActionButton(
            title: LocaleKeys.addOrder,
            onTap: () async {
              final createdOrder = await Go.to(const CreateOrdersScreen());
              if (createdOrder != null && context.mounted) {
                context.read<AdminHomeCubit>().fetchHome();
              }
            },
          ),
        ),
        SizedBox(width: AppSize.sW8),
        Expanded(
          child: _AdminActionButton(
            title: LocaleKeys.addEmployee,
            onTap: () async {
              final createdEmployee = await Go.to(const CreateEmployeeScreen());
              if (createdEmployee != null && context.mounted) {
                context.read<AdminHomeCubit>().fetchHome();
              }
            },
          ),
        ),
      ],
    );
  }
}
