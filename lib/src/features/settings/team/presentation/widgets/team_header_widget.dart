part of '../imports/view_imports.dart';

class TeamHeaderWidget extends StatelessWidget {
  const TeamHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/profile_backgroung.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            top: 45.h,
            start: AppPadding.pW18,
            child: Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                color: AppColors.black.withValues(alpha: .45),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: Go.back,
                icon: Icon(Icons.arrow_back_ios_rounded,
                  color: AppColors.white,
                  size: 14.sp,)

              ),
            ),
          ),
          PositionedDirectional(
            end: AppPadding.pW18,
            bottom: 23.h,
            child: Container(
              width: 58.w,
              height: 58.w,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppCircular.r12),
                boxShadow: [AppColors.containerShadow],
              ),
              child: AppAssets.images.taemLogo.image(),
            ),
          ),
          PositionedDirectional(
            start: AppPadding.pW18,
            bottom: 26.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.teamName,
                  style: const TextStyle().setWhiteColor.s20.bold,
                ),
                4.h.szH,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      LocaleKeys.teamPlayersCount,
                      style: const TextStyle().setWhiteColor.s12.medium,
                    ),
                    5.w.szW,
                    Icon(
                      Icons.person_rounded,
                      color: AppColors.white,
                      size: 13.sp,
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
