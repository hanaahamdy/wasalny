part of '../../../../../home/presentation/imports/view_imports.dart';

class AdminHome extends StatelessWidget {
  final HomeModel data;

  const AdminHome({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    context.locale;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Column(
        children: [
          const HomeHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                AppPadding.pW8,
                AppPadding.pH12,
                AppPadding.pW8,
                AppPadding.pH20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _AdminHomeStats(data: data),
                  SizedBox(height: AppSize.sH14),
                  const AdminHomeActions(),
                  SizedBox(height: AppSize.sH16),
                  Row(
                    children: [
                      Text(
                        LocaleKeys.latestOrders,
                        style: TextStyle(
                          color: AppColors.main,
                          fontSize: FontSizeManager.s13,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        LocaleKeys.viewAll,
                        style: TextStyle(
                          color: AppColors.scenarioPrimary,
                          fontSize: FontSizeManager.s11,
                          fontWeight: FontWeightManager.regular,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.sH10),
                  ...data.latestOrders.map(
                    (order) => Padding(
                      padding: EdgeInsets.only(bottom: AppPadding.pH10),
                      child: OrderCard(order: order),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminHomeStats extends StatelessWidget {
  final HomeModel data;

  const _AdminHomeStats({required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: HomeOrderSummaryCard(
            value: data.ordersCount.toString(),
            label: LocaleKeys.orderCount,
            icon: Icons.inventory_2_outlined,
            iconBackground: AppColors.settingsLanguageIconBackground,
            iconColor: AppColors.settingsLanguageIcon,
          ),
        ),
        SizedBox(width: AppSize.sW8),
        Expanded(
          child: HomeOrderSummaryCard(
            value: data.deliveryCount.toString(),
            label: LocaleKeys.deliveryCount,
            icon: Icons.local_shipping_outlined,
            iconBackground: AppColors.moreProfileIconBackground,
            iconColor: AppColors.scenarioPrimary,
          ),
        ),
      ],
    );
  }
}

class OrderStatusChip extends StatelessWidget {
  final OrderStatusData status;

  const OrderStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW10,
        vertical: AppPadding.pH4,
      ),
      decoration: BoxDecoration(
        color: status.background,
        borderRadius: BorderRadius.circular(AppCircular.r8),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: status.textColor,
          fontSize: FontSizeManager.s10,
          fontWeight: FontWeightManager.medium,
        ),
      ),
    );
  }
}

class OrderStatusData {
  final String label;
  final Color background;
  final Color textColor;

  const OrderStatusData({
    required this.label,
    required this.background,
    required this.textColor,
  });
}
