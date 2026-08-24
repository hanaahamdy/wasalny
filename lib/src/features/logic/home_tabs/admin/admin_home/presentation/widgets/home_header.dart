part of '../imports/presentation_imports.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppColors.buttonGradient),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: AppSize.sH70,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.pW14),
            child: Row(
              children: [
                Column(
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
                      LocaleKeys.adminHome,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: FontSizeManager.s15,
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
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
