part of '../../imports/presentation_imports.dart';

class DeliveryProfileCard extends StatelessWidget {
  final DeliveryModel delivery;

  const DeliveryProfileCard({super.key, required this.delivery});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW16,
        vertical: AppPadding.pH14,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        border: Border.all(color: AppColors.inputBorder),
        boxShadow: [AppColors.containerShadow],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: AppSize.sW25,
            backgroundColor: AppColors.scenarioPrimary,
            child: Text(
              delivery.name.characters.first,
              style: TextStyle(
                color: AppColors.white,
                fontSize: FontSizeManager.s18,
                fontWeight: FontWeightManager.bold,
              ),
            ),
          ),
          SizedBox(height: AppSize.sH8),
          Text(
            delivery.name,
            style: TextStyle(
              color: AppColors.main,
              fontSize: FontSizeManager.s14,
              fontWeight: FontWeightManager.bold,
            ),
          ),
          SizedBox(height: AppSize.sH2),
          Text(
            delivery.phone,
            style: TextStyle(
              color: AppColors.hintText,
              fontSize: FontSizeManager.s10,
            ),
          ),
          SizedBox(height: AppSize.sH4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.hintText,
                size: AppSize.sH12,
              ),
              SizedBox(width: AppSize.sW2),
              Text(
                delivery.location,
                style: TextStyle(
                  color: AppColors.hintText,
                  fontSize: FontSizeManager.s10,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.sH6),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.pW10,
              vertical: AppPadding.pH4,
            ),
            decoration: BoxDecoration(
              color: AppColors.successGreen.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(AppCircular.r20),
            ),
            child: Text(
              delivery.isActive ? LocaleKeys.active : LocaleKeys.inactive,
              style: TextStyle(
                color: delivery.isActive
                    ? AppColors.successGreen
                    : AppColors.hintText,
                fontSize: FontSizeManager.s10,
                fontWeight: FontWeightManager.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
