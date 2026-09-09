part of '../imports/presentation_imports.dart';

class AdminSalesDeliveryTotal extends StatelessWidget {
  final int amount;

  const AdminSalesDeliveryTotal({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW12,
        vertical: AppPadding.pH10,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        border: Border.all(color: AppColors.inputBorder),
        boxShadow: [AppColors.containerShadow],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            LocaleKeys.totalDeliveryFees,
            style: TextStyle(
              color: AppColors.main,
              fontSize: FontSizeManager.s12,
              fontWeight: FontWeightManager.bold,
            ),
          ),
          Text(
            '${_formatAmount(amount)} ${LocaleKeys.egyptianPound}',
            style: TextStyle(
              color: AppColors.scenarioPrimary,
              fontSize: FontSizeManager.s12,
              fontWeight: FontWeightManager.bold,
            ),
          ),
        ],
      ),
    );
  }
}
