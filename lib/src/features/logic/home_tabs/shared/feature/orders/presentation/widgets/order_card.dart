part of '../imports/view_imports.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final status = _statusData(order.adminTab);

    return InkWell(
      borderRadius: BorderRadius.circular(AppCircular.r12),
      onTap: () => Go.to(OrderDetailsScreen(order: order)),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pW12,
          vertical: AppPadding.pH12,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppCircular.r12),
          border: Border.all(color: AppColors.inputBorder),
          boxShadow: [AppColors.containerShadow],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${order.id.replaceFirst('#', 'ORD-')}#',
                    style: TextStyle(
                      color: AppColors.main,
                      fontSize: FontSizeManager.s12,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                  SizedBox(height: AppSize.sH8),
                  Text(
                    order.customerName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.main,
                      fontSize: FontSizeManager.s12,
                      fontWeight: FontWeightManager.medium,
                    ),
                  ),
                  SizedBox(height: AppSize.sH4),
                  Text(
                    order.phone,
                    style: TextStyle(
                      color: AppColors.hintText,
                      fontSize: FontSizeManager.s10,
                      fontWeight: FontWeightManager.regular,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderStatusChip(status: status),
                SizedBox(height: AppSize.sH22),
                Text(
                  order.createdAt,
                  style: TextStyle(
                    color: AppColors.notificationTimeText,
                    fontSize: FontSizeManager.s10,
                    fontWeight: FontWeightManager.regular,
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  OrderStatusData _statusData(AdminOrderTab tab) {
    return switch (tab) {
      AdminOrderTab.pending => OrderStatusData(
        label: AdminOrderTab.pending.label,
        background: AppColors.moreTermsIconBackground,
        textColor: AppColors.bookingPendingYellow,
      ),
      AdminOrderTab.created => OrderStatusData(
        label: AdminOrderTab.created.label,
        background: AppColors.settingsProfileIconBackground,
        textColor: AppColors.authTabSelected,
      ),

      AdminOrderTab.delivering => OrderStatusData(
        label: AdminOrderTab.delivering.label,
        background: AppColors.settingsProfileIconBackground,
        textColor: AppColors.authTabSelected,
      ),
      AdminOrderTab.received => OrderStatusData(
        label: AdminOrderTab.received.label,
        background: AppColors.settingsProfileIconBackground,
        textColor: AppColors.authTabSelected,
      ),
      AdminOrderTab.cancelled => OrderStatusData(
        label: AdminOrderTab.created.label,
        background: AppColors.settingsProfileIconBackground,
        textColor: AppColors.authTabSelected,
      ),
    };
  }
}
