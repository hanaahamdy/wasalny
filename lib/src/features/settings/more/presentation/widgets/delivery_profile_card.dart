part of '../more_screen.dart';

class _DeliveryProfileCard extends StatelessWidget {
  final UserModel user;

  const _DeliveryProfileCard({required this.user});

  @override
  Widget build(BuildContext context) {
    final name = user.fullName.trim().isEmpty
        ? LocaleKeys.deliveryStaff
        : user.fullName;
    final initial = name.characters.first;

    return Container(
      padding: EdgeInsets.all(AppPadding.pW12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r12),
        border: Border.all(color: AppColors.inputBorder),
        boxShadow: [AppColors.containerShadow],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppSize.sW25,
            backgroundColor: AppColors.authTabSelected,
            child: Text(
              initial,
              style: TextStyle(
                color: AppColors.white,
                fontSize: FontSizeManager.s18,
                fontWeight: FontWeightManager.bold,
              ),
            ),
          ),
          SizedBox(width: AppSize.sW12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: AppColors.main,
                    fontSize: FontSizeManager.s14,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
                if (user.phoneNumber.trim().isNotEmpty)
                  Text(
                    user.phoneNumber,
                    style: TextStyle(
                      color: AppColors.hintText,
                      fontSize: FontSizeManager.s10,
                    ),
                  ),
                Row(
                  children: [
                    Container(
                      width: AppSize.sW6,
                      height: AppSize.sW6,
                      decoration: const BoxDecoration(
                        color: AppColors.successGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: AppSize.sW4),
                    Text(
                      LocaleKeys.active,
                      style: TextStyle(
                        color: AppColors.successGreen,
                        fontSize: FontSizeManager.s10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
