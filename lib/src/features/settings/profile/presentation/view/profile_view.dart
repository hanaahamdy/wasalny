part of '../imports/view_imports.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..fetchProfile(),
      child: const _ProfileContent(),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent();

  @override
  Widget build(BuildContext context) {
    context.locale;
    final user =
        context.watch<ProfileCubit>().state.data ?? UserCubit.instance.user;
    final name = user.fullName.isEmpty ? LocaleKeys.visitorText : user.fullName;
    final handle = user.email.isNotEmpty
        ? '@${user.email.split('@').first}'
        : '@ahmed.sami';
    final profileFields = <({String label, String value})>[
      (
        label: LocaleKeys.signUpGender,
        value: user.gender.isEmpty ? LocaleKeys.signUpMale : user.gender,
      ),
      (
        label: LocaleKeys.signUpBirthDate,
        value: user.birthDate.isEmpty
            ? LocaleKeys.signUpBirthDateHint
            : user.birthDate,
      ),
      (
        label: LocaleKeys.location,
        value: user.location.isEmpty ? LocaleKeys.location : user.location,
      ),
      (
        label: LocaleKeys.signUpCity,
        value: user.city.isEmpty ? LocaleKeys.signUpCity : user.city,
      ),
      (
        label: LocaleKeys.signUpDistrict,
        value: user.district.isEmpty
            ? LocaleKeys.signUpDistrict
            : user.district,
      ),
    ];

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
                    ...profileFields.indexed.map((entry) {
                      final (index, field) = entry;
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == profileFields.length - 1 ? 0 : 20.h,
                        ),
                        child: CustomTextFiled(
                          title: field.label,
                          hint: field.value,
                          controller: null,
                          textInputType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: null,
                          readOnly: true,
                          isOptional: true,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      );
                    }),
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

class _ProfileAvatar extends StatelessWidget {
  final String userImage;

  const _ProfileAvatar({required this.userImage});

  @override
  Widget build(BuildContext context) {
    final fallback = ColoredBox(
      color: AppColors.avatarBackground,
      child: AppAssets.svg.baseSvg.userVector.svg(fit: BoxFit.cover),
    );

    return SizedBox(
      width: 120.r,
      height: 120.r,
      child: ClipOval(
        child: userImage.isEmpty
            ? fallback
            : CachedImage(
                url: userImage,
                width: 120.r,
                height: 120.r,
                boxShape: BoxShape.circle,
                placeHolder: fallback,
              ),
      ),
    );
  }
}
