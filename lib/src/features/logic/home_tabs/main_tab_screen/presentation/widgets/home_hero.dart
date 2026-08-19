part of '../imports/main_tab_screen_imports.dart';

class _HomeHero extends StatelessWidget {
  final VoidCallback onSearchTap;
  final VoidCallback onNotificationTap;

  const _HomeHero({required this.onSearchTap, required this.onNotificationTap});

  @override
  Widget build(BuildContext context) {
    final user = context.select((UserCubit cubit) => cubit.state.userModel);
    final userName = user.fullName.trim().isEmpty
        ? LocaleKeys.stadiumsUserName
        : user.fullName.trim();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 272.h,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1570498839593-e565b39455fc?auto=format&fit=crop&w=1200&q=80',
              ),
              fit: BoxFit.cover,
            ),
          ),
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.04),
                const Color(0xFF00A56A).withValues(alpha: 0.74),
              ],
            ),
          ),
        ),
        PositionedDirectional(
          top: 54.h,
          end: 24.w,
          child: _CircleIconButton(
            icon: Icons.notifications_none_rounded,
            onTap: onNotificationTap,
          ),
        ),
        PositionedDirectional(
          top: 52.h,
          start: 24.w,
          child: Row(
            children: [
              _HomeUserAvatar(imageUrl: user.image),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.stadiumsWelcomeUser,
                    style: TextStyle(color: AppColors.white, fontSize: 11.sp),
                  ),
                  Text(
                    userName,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        PositionedDirectional(
          top: 132.h,
          start: 24.w,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${LocaleKeys.stadiumsHeroEyebrow}\n',
                  style: TextStyle(fontSize: 13.sp, height: 1.8),
                ),
                TextSpan(
                  text: LocaleKeys.stadiumsHeroTitle,
                  style: TextStyle(
                    fontSize: 24.sp,
                    height: 1.2,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.right,
            style: const TextStyle(color: AppColors.white),
          ),
        ),
        PositionedDirectional(
          start: 22.w,
          end: 22.w,
          bottom: -28.h,
          child: MainTabSearch(onSearch: onSearchTap, readOnly: true),
        ),
      ],
    );
  }
}

class _HomeUserAvatar extends StatelessWidget {
  final String imageUrl;

  const _HomeUserAvatar({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.r,
      width: 44.r,
      padding: EdgeInsets.all(2.r),
      decoration: const BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: imageUrl.trim().isEmpty
            ? const _HomeUserAvatarFallback()
            : CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                errorWidget: (_, _, _) => const _HomeUserAvatarFallback(),
              ),
      ),
    );
  }
}

class _HomeUserAvatarFallback extends StatelessWidget {
  const _HomeUserAvatarFallback();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.avatarBackground,
      child: Icon(
        Icons.person_rounded,
        color: AppColors.avatarIcon,
        size: 26.r,
      ),
    );
  }
}
