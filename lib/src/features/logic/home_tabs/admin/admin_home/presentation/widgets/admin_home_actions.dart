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
            onTap: () => Go.to(const CreateOrdersScreen()),
          ),
        ),
        SizedBox(width: AppSize.sW8),
        Expanded(
          child: _AdminActionButton(
            title: LocaleKeys.addDelivery,
            onTap: () =>Go.to(const CreateDeliveryScreen()),
          ),
        ),
      ],
    );
  }
}