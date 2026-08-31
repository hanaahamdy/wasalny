part of '../imports/presentation_imports.dart';

class DeliveredOrdersCard extends StatelessWidget {
  final List<DeliveryRecord> deliveries;

  const DeliveredOrdersCard({super.key, required this.deliveries});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        border: Border.all(color: AppColors.inputBorder),
        boxShadow: [AppColors.containerShadow],
      ),
      child: Column(
        children: List.generate(deliveries.length, (index) {
          return Column(
            children: [
              DeliveredOrderRow(delivery: deliveries[index]),
              if (index < deliveries.length - 1)
                const Divider(height: 1, color: AppColors.inputBorder),
            ],
          );
        }),
      ),
    );
  }
}
