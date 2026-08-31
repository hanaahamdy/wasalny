part of '../imports/presentation_imports.dart';

class DeliveredOrderRow extends StatelessWidget {
  final DeliveryRecord delivery;

  const DeliveredOrderRow({super.key, required this.delivery});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.pW12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  delivery.orderNumber,
                  style: TextStyle(
                    color: AppColors.authTabSelected,
                    fontSize: FontSizeManager.s11,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
                SizedBox(height: AppSize.sH4),
                Text(
                  delivery.customerName,
                  style: TextStyle(
                    color: AppColors.hintText,
                    fontSize: FontSizeManager.s10,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${delivery.fee} ${LocaleKeys.egyptianPound}',
                style: TextStyle(
                  color: AppColors.authTabSelected,
                  fontSize: FontSizeManager.s11,
                  fontWeight: FontWeightManager.bold,
                ),
              ),
              SizedBox(height: AppSize.sH4),
              Text(
                delivery.date,
                style: TextStyle(
                  color: AppColors.hintText,
                  fontSize: FontSizeManager.s10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
