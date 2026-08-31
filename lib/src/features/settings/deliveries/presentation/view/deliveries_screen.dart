part of '../imports/presentation_imports.dart';

class DeliveriesScreen extends StatelessWidget {
  const DeliveriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.deliveryStaff)),
      body: const DeliveriesBody(),
    );
  }
}
