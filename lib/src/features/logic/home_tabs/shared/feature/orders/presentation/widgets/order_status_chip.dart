part of '../imports/view_imports.dart';

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
