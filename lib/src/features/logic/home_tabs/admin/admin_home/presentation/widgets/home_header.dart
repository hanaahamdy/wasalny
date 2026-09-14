part of '../imports/presentation_imports.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = context.select<UserCubit, String>(
      (cubit) => cubit.state.userModel.name.trim(),
    );

    return DecoratedBox(
      decoration: BoxDecoration(gradient: AppColors.scenarioGradient),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: AppSize.sH70,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.pW14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.hello,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: FontSizeManager.s11,
                          fontWeight: FontWeightManager.regular,
                        ),
                      ),
                      SizedBox(height: AppSize.sH2),
                      Text(
                        userName.isEmpty ? LocaleKeys.adminHome : userName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: FontSizeManager.s15,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                NotificationIcon(
                  icon: Icons.notifications_none_rounded,
                  color: AppColors.bookingPendingYellow,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
