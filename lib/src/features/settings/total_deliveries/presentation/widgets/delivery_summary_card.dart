part of '../imports/presentation_imports.dart';

class DeliverySummaryCard extends StatelessWidget {
  final int count;

  const DeliverySummaryCard({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppPadding.pW14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        border: Border.all(color: AppColors.inputBorder),
        boxShadow: [AppColors.containerShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: AppSize.sW30,
            height: AppSize.sW30,
            decoration: BoxDecoration(
              color: AppColors.moreIconBackground,
              borderRadius: BorderRadius.circular(AppCircular.r8),
            ),
            child: Icon(
              Icons.local_shipping_outlined,
              color: AppColors.authTabSelected,
              size: AppSize.sH18,
            ),
          ),
          SizedBox(height: AppSize.sH8),
          Text(
            count.toString(),
            style: TextStyle(
              color: AppColors.main,
              fontSize: FontSizeManager.s18,
              fontWeight: FontWeightManager.bold,
            ),
          ),
          Text(
            LocaleKeys.completedDeliveriesCount,
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
