part of '../imports/presentation_imports.dart';

class AdminSaleRow extends StatelessWidget {
  final AdminSaleModel sale;

  const AdminSaleRow({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: AppColors.main,
      fontSize: FontSizeManager.s10,
      fontWeight: FontWeightManager.regular,
    );
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW10,
        vertical: AppPadding.pH10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              sale.orderNumber,
              style: textStyle.copyWith(color: AppColors.introGradientEnd),
            ),
          ),
          Expanded(child: Text(sale.customerName, style: textStyle)),
          Expanded(
            child: Text(
              _formatAmount(sale.amount),
              textAlign: TextAlign.end,
              style: textStyle.copyWith(
                color: AppColors.scenarioPrimary,
                fontWeight: FontWeightManager.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
