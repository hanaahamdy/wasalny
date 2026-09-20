part of '../imports/view_imports.dart';

class DeliveryOrderDetailsActions extends StatelessWidget {
  final DeliveryOrderTab status;
  final VoidCallback? onStartDelivery;
  final VoidCallback? onDelivered;

  const DeliveryOrderDetailsActions({
    super.key,
    required this.status,
    this.onStartDelivery,
    this.onDelivered,
  });

  @override
  Widget build(BuildContext context) {
    if (status == DeliveryOrderTab.created && onStartDelivery != null) {
      return Padding(
        padding: EdgeInsets.only(top: AppSize.sH18),
        child: DefaultButton(
          title: LocaleKeys.startDelivery,
          onTap: onStartDelivery,
        ),
      );
    }

    if (status != DeliveryOrderTab.delivering || onDelivered == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(top: AppSize.sH18),
      child: DefaultButton(
        title: LocaleKeys.markAsDelivered,
        onTap: onDelivered,
      ),
    );
  }
}
