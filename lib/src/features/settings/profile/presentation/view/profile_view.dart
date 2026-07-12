part of '../imports/view_imports.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;
    final user = UserCubit.instance.user;
    final name = user.fullName.isEmpty ? LocaleKeys.visitorText : user.fullName;
    final handle = user.email.isNotEmpty ? user.email : '@ahmed.sami';

    return Scaffold(
      appBar: CustomAppbar(title: LocaleKeys.profile),
      backgroundColor: AppColors.subtleBackground,
      body: CustomScrollView(
        slivers: [

          SliverPadding(
            padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 34.h),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.fromLTRB(16.w, 33.h, 16.w, 26.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Column(
                  children: [
                    _ProfileAvatar(userImage: user.image),
                    SizedBox(height: 28.h),
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Text(
                      handle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    _ProfileReadonlyField(
                      label: LocaleKeys.signUpType,
                      value: LocaleKeys.signUpPlayer,
                    ),
                    _ProfileReadonlyField(
                      label: LocaleKeys.signUpGender,
                      value: LocaleKeys.signUpMale,
                    ),
                    _ProfileReadonlyField(
                      label: LocaleKeys.signUpBirthDate,
                      value: LocaleKeys.signUpBirthDateHint,
                    ),
                    _ProfileReadonlyField(
                      label: LocaleKeys.location,
                      value: LocaleKeys.location,
                    ),
                    _ProfileReadonlyField(
                      label: LocaleKeys.signUpCity,
                      value: user.city.isEmpty
                          ? LocaleKeys.signUpCity
                          : user.city,
                    ),
                    _ProfileReadonlyField(
                      label: LocaleKeys.signUpDistrict,
                      value: LocaleKeys.signUpDistrict,
                      bottomSpacing: 0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final String title;

  const _ProfileHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 121.h,
      decoration: BoxDecoration(
        color: AppColors.authTabSelected,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.r)),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            PositionedDirectional(
              start: 18.w,
              top: 14.h,
              child: IconButton(
                onPressed: () => Go.back(),
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                  size: 24.r,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 14.h),
              child: Text(
                title,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  final String userImage;

  const _ProfileAvatar({required this.userImage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.r,
      height: 120.r,
      child: ClipOval(
        child: userImage.isEmpty
            ? AppAssets.svg.baseSvg.userVector.svg(fit: BoxFit.cover)
            : CachedImage(
                url: userImage,
                width: 120.r,
                height: 120.r,
                boxShape: BoxShape.circle,
              ),
      ),
    );
  }
}

class _ProfileReadonlyField extends StatelessWidget {
  final String label;
  final String value;
  final double bottomSpacing;

  const _ProfileReadonlyField({
    required this.label,
    required this.value,
    this.bottomSpacing = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            height: 56.h,
            width: double.infinity,
            alignment: AlignmentDirectional.centerStart,
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            decoration: BoxDecoration(
              color: AppColors.fieldFillColor,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.hintText,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
