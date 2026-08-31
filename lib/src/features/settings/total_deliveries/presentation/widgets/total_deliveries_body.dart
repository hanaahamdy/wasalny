part of '../imports/presentation_imports.dart';

class TotalDeliveriesBody extends StatelessWidget {
  const TotalDeliveriesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final deliveries = DeliveryRecord.samples;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW10,
        vertical: AppPadding.pH10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MonthSelector(),
          SizedBox(height: AppSize.sH10),
          DeliverySummaryCard(count: deliveries.length),
          SizedBox(height: AppSize.sH10),
          Text(
            LocaleKeys.deliveredOrders,
            style: TextStyle(
              color: AppColors.hintText,
              fontSize: FontSizeManager.s10,
              fontWeight: FontWeightManager.medium,
            ),
          ),
          SizedBox(height: AppSize.sH6),
          DeliveredOrdersCard(deliveries: deliveries),
        ],
      ),
    );
  }
}
