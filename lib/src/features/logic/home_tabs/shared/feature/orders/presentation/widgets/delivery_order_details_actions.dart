part of '../imports/view_imports.dart';

class DeliveryOrderDetailsActions extends StatelessWidget {
  final DeliveryOrderTab status;
  final VoidCallback? onStartDelivery;
  final VoidCallback? onTrackOrder;
  final VoidCallback? onDelivered;
  final bool isLoading;

  const DeliveryOrderDetailsActions({
    super.key,
    required this.status,
    this.onStartDelivery,
    this.onTrackOrder,
    this.onDelivered,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (status == DeliveryOrderTab.created && onStartDelivery != null) {
      return Padding(
        padding: EdgeInsets.only(top: AppSize.sH18),
        child: DefaultButton(
          title: LocaleKeys.startDelivery,
          onTap: isLoading ? null : onStartDelivery,
        ),
      );
    }

    if (status != DeliveryOrderTab.delivering ||
        onTrackOrder == null ||
        onDelivered == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(top: AppSize.sH18),
      child: Row(
        children: [
          Expanded(
            child: DefaultButton(
              title: LocaleKeys.openTracking,
              color: AppColors.error,
              onTap: isLoading ? null : onTrackOrder,
            ),
          ),
          SizedBox(width: AppSize.sW10),
          Expanded(
            child: DefaultButton(
              title: LocaleKeys.markAsDelivered,
              onTap: isLoading ? null : onDelivered,
            ),
          ),
        ],
      ),
    );
  }
}
