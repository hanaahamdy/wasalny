part of '../../imports/presentation_imports.dart';

class DeliveryDetailsBody extends StatelessWidget {
  final DeliveryModel delivery;

  const DeliveryDetailsBody({super.key, required this.delivery});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW8,
        vertical: AppPadding.pH12,
      ),
      child: Column(
        children: [
          DeliveryProfileCard(delivery: delivery),
          SizedBox(height: AppSize.sH10),
          DefaultButton(
            width: double.infinity,
            height: AppSize.sH45,
            title: LocaleKeys.editDeliveryData,
            onTap: () => Go.to(EditDeliveryProfileScreen(delivery: delivery)),
            customChild: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LocaleKeys.editDeliveryData,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: FontSizeManager.s12,
                    fontWeight: FontWeightManager.medium,
                  ),
                ),
                SizedBox(width: AppSize.sW6),
                Icon(
                  Icons.edit_outlined,
                  color: AppColors.white,
                  size: AppSize.sH16,
                ),
              ],
            ),
          ),
          SizedBox(height: AppSize.sH10),
          DefaultButton(
            width: double.infinity,
            height: AppSize.sH45,
            title: LocaleKeys.disableAccount,
            color: AppColors.white,
            textColor: AppColors.main,
            borderColor: AppColors.inputBorder,
            onTap: () {},
          ),
          SizedBox(height: AppSize.sH10),
          DefaultButton(
            width: double.infinity,
            height: AppSize.sH45,
            title: LocaleKeys.deleteDelivery,
            color: AppColors.error,
            onTap: () {},
            customChild: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LocaleKeys.deleteDelivery,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: FontSizeManager.s12,
                    fontWeight: FontWeightManager.medium,
                  ),
                ),
                SizedBox(width: AppSize.sW6),
                Icon(
                  Icons.delete_outline,
                  color: AppColors.white,
                  size: AppSize.sH16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
