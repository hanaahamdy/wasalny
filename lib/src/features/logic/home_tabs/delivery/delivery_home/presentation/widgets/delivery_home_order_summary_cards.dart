part of '../imports/presentation_imports.dart';

class DeliveryHomeOrderSummaryCards extends StatelessWidget {
  final HomeModel data;

  const DeliveryHomeOrderSummaryCards({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: HomeOrderSummaryCard(
            value: data.createdOrders.toString(),
            label: LocaleKeys.createdOrders,
            icon: Icons.calculate_rounded,
            iconBackground: AppColors.settingsLanguageIconBackground,
            iconColor: AppColors.settingsLanguageIcon,
          ),
        ),
        SizedBox(width: AppSize.sW8),
        Expanded(
          child: HomeOrderSummaryCard(
            value: data.deliveredOrders.toString(),
            label: LocaleKeys.delivered,
            icon: Icons.check_circle_outline,
            iconBackground: AppColors.moreProfileIconBackground,
            iconColor: AppColors.scenarioPrimary,
          ),
        ),
      ],
    );
  }
}
