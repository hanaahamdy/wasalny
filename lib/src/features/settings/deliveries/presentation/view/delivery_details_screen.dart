part of '../imports/presentation_imports.dart';

class DeliveryDetailsScreen extends StatelessWidget {
  final DeliveryModel delivery;

  const DeliveryDetailsScreen({super.key, required this.delivery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.deliveryDetails),
        flexibleSpace: DecoratedBox(
          decoration: BoxDecoration(gradient: AppColors.scenarioGradient),
        ),
      ),
      body: DeliveryDetailsBody(delivery: delivery),
    );
  }
}
