part of '../imports/presentation_imports.dart';

class AdminSalesSummaryCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final bool showCurrency;

  const AdminSalesSummaryCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.showCurrency = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.sH100,
      padding: EdgeInsets.all(AppPadding.pW12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        border: Border.all(color: AppColors.inputBorder),
        boxShadow: [AppColors.containerShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              width: AppSize.sW30,
              height: AppSize.sW30,
              decoration: const BoxDecoration(
                color: AppColors.moreIconBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.scenarioPrimary,
                size: AppSize.sH18,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: AppColors.main,
                  fontSize: FontSizeManager.s18,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
              if (showCurrency) ...[
                SizedBox(width: AppSize.sW4),
                Text(
                  LocaleKeys.egyptianPoundShort,
                  style: TextStyle(
                    color: AppColors.main,
                    fontSize: FontSizeManager.s11,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
              ],
            ],
          ),
          Text(
            label,
            style: TextStyle(
              color: AppColors.hintText,
              fontSize: FontSizeManager.s10,
            ),
          ),
        ],
      ),
    );
  }
}
