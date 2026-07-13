part of '../imports/view_imports.dart';

class _MoreTabBody extends StatelessWidget {
  const _MoreTabBody();

  @override
  Widget build(BuildContext context) {
    context.locale;
    final generalItems = MoreItemEntity.generalItems;
    final otherItems = MoreItemEntity.otherItems;

    return Scaffold(
      backgroundColor: AppColors.subtleBackground,
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: _MoreProfileHeader()),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(24.w, 22.h, 24.w, 18.h),
            sliver: SliverList.list(
              children: [
                _MoreSectionWidget(
                  titleKey: LocaleKeys.moreAccountTitle,
                  items: generalItems,
                ),
                SizedBox(height: 24.h),
                _MoreSectionWidget(
                  titleKey: LocaleKeys.moreAboutAppTitle,
                  items: otherItems,
                ),
                SizedBox(height: 18.h),
                const _MoreLogoutButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MoreProfileHeader extends StatelessWidget {
  const _MoreProfileHeader();

  @override
  Widget build(BuildContext context) {
    final user = UserCubit.instance.user;
    final userName = user.fullName.isEmpty
        ? LocaleKeys.visitorText
        : user.fullName;
    final handle = user.email.isNotEmpty ? user.email : '@ahmed.sami';

    return SizedBox(
      height: 299.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  AppColors.moreHeaderGreen,
                  AppColors.moreHeaderDarkGreen,
                ],
              ),
            ),
          ),
          Positioned(
            top: -30.h,
            left: -50.w,
            child: _MoreHeaderCurve(
              width: 290.w,
              height: 190.h,
              color: AppColors.white.withValues(alpha: .10),
            ),
          ),
          Positioned(
            right: -50.w,
            bottom: 18.h,
            child: _MoreHeaderCurve(
              width: 360.w,
              height: 170.h,
              color: AppColors.black.withValues(alpha: .20),
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  SizedBox(height: 48.h),
                  Container(
                    width: 96.r,
                    height: 96.r,
                    padding: EdgeInsets.all(4.r),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: user.image.isEmpty
                          ? AppAssets.svg.baseSvg.userVector.svg(
                              fit: BoxFit.cover,
                            )
                          : CachedImage(
                              url: user.image,
                              width: 88.r,
                              height: 88.r,
                              boxShape: BoxShape.circle,
                            ),
                    ),
                  ),
                  SizedBox(height: 22.h),
                  Text(
                    userName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    handle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.white.withValues(alpha: .94),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoreHeaderCurve extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const _MoreHeaderCurve({
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.22,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(120.r),
        ),
      ),
    );
  }
}

class _MoreLogoutButton extends StatelessWidget {
  const _MoreLogoutButton();

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Container(
      height: 52.h,
      decoration: BoxDecoration(
        color: AppColors.moreLogoutBackground,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.logout,
            style: TextStyle(
              color: AppColors.moreLogoutText,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 12.w),
          Icon(Icons.logout, color: AppColors.moreLogoutText, size: 20.r),
        ],
      ),
    ).onClick(onTap: () async => await logOut());
  }
}
