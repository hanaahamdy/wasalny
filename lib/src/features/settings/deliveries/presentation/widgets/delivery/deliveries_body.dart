part of '../../imports/presentation_imports.dart';

class DeliveriesBody extends StatelessWidget {
  const DeliveriesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW12,
        vertical: AppPadding.pH14,
      ),
      itemCount: DeliveryModel.samples.length,
      separatorBuilder: (_, _) => SizedBox(height: AppSize.sH10),
      itemBuilder: (_, index) =>
          DeliveryCard(delivery: DeliveryModel.samples[index]),
    );
  }
}
