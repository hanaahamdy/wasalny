part of '../imports/presentation_imports.dart';

class DeliveryHomeOrderSummaryCards extends StatelessWidget {
  const DeliveryHomeOrderSummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryHomeCubit, RequestState<DeliveryHomeModel?>>(
      builder: (context, state) {
        final data = state.data;
        final loadingValue = state.isLoading && data == null ? '...' : null;

        return Row(
          children: [
            Expanded(
              child: HomeOrderSummaryCard(
                value: loadingValue ?? (data?.createdOrders ?? 0).toString(),
                label: LocaleKeys.createdOrders,
                icon: Icons.calculate_rounded,
                iconBackground: AppColors.settingsLanguageIconBackground,
                iconColor: AppColors.settingsLanguageIcon,
              ),
            ),
            SizedBox(width: AppSize.sW8),
            Expanded(
              child: HomeOrderSummaryCard(
                value: loadingValue ?? (data?.deliveredOrders ?? 0).toString(),
                label: LocaleKeys.delivered,
                icon: Icons.check_circle_outline,
                iconBackground: AppColors.moreProfileIconBackground,
                iconColor: AppColors.scenarioPrimary,
              ),
            ),
          ],
        );
      },
    );
  }
}
