part of '../imports/presentation_imports.dart';

class TotalDeliveriesScreen extends StatelessWidget {
  const TotalDeliveriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.myDeliveries),
      body: const TotalDeliveriesBody(),
    );
  }
}
