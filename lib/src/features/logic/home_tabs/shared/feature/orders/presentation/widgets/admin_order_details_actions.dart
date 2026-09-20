part of '../imports/view_imports.dart';

class AdminOrderDetailsActions extends StatelessWidget {
  final AdminOrderTab status;
  final VoidCallback? onCancelOrder;
  final VoidCallback? onResendOrder;
  final VoidCallback? onTrackOrder;

  const AdminOrderDetailsActions({
    super.key,
    required this.status,
    this.onCancelOrder,
    this.onResendOrder,
    this.onTrackOrder,
  });

  @override
  Widget build(BuildContext context) {
    if (status == AdminOrderTab.onHolding &&
        onCancelOrder != null &&
        onResendOrder != null) {
      return Padding(
        padding: EdgeInsets.only(top: AppSize.sH18),
        child: Row(
          children: [
            Expanded(
              child: DefaultButton(
                title: LocaleKeys.cancelOrder,
                color: AppColors.error,
                onTap: onCancelOrder,
              ),
            ),
            SizedBox(width: AppSize.sW10),
            Expanded(
              child: DefaultButton(
                title: LocaleKeys.resendOrder,
                onTap: onResendOrder,
              ),
            ),
          ],
        ),
      );
    }

    if (status == AdminOrderTab.delivering && onTrackOrder != null) {
      return Padding(
        padding: EdgeInsets.only(top: AppSize.sH18),
        child: DefaultButton(title: LocaleKeys.trackOrder, onTap: onTrackOrder),
      );
    }

    return const SizedBox.shrink();
  }
}
