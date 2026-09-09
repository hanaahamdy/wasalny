part of '../imports/presentation_imports.dart';

class EditDeliveryProfileScreen extends StatelessWidget {
  final DeliveryModel delivery;

  const EditDeliveryProfileScreen({super.key, required this.delivery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.editDeliveryProfile),
        flexibleSpace: DecoratedBox(
          decoration: BoxDecoration(gradient: AppColors.scenarioGradient),
        ),
      ),
      body: EditDeliveryProfileBody(delivery: delivery),
    );
  }
}
