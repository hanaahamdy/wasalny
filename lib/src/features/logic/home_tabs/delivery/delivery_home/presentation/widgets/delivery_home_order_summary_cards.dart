part of '../imports/presentation_imports.dart';
class DeliveryHomeOrderSummaryCards extends StatelessWidget {
  const DeliveryHomeOrderSummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: HomeOrderSummaryCard(
            value: OrderModel.samples.length.toString(),
            label: LocaleKeys.createdOrders,
            icon: Icons.calculate_rounded,
            iconBackground: AppColors.settingsLanguageIconBackground,
            iconColor: AppColors.settingsLanguageIcon,
          ),
        ),
        SizedBox(width: AppSize.sW8),
        Expanded(
          child: HomeOrderSummaryCard(
            value: '4',
            label: LocaleKeys.delivered,
            icon: Icons.check_circle_outline,
            iconBackground: AppColors.moreProfileIconBackground,
            iconColor: AppColors.authTabSelected,
          ),
        ),
      ],
    );
  }
}
