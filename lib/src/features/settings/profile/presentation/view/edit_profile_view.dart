part of '../imports/view_imports.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserCubit.instance.user;

    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.subtleBackground,
        appBar: CustomAppbar(title: LocaleKeys.settingsEditProfile),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24.w, 23.h, 24.w, 32.h),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(16.w, 33.h, 16.w, 24.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: .05),
                      blurRadius: 55.r,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _EditProfileAvatar(userImage: user.image),
                    SizedBox(height: 24.h),
                    _EditProfileField(
                      label: LocaleKeys.signUpType,
                      hint: LocaleKeys.signUpPlayer,
                      icon: Icons.keyboard_arrow_down_rounded,
                      readOnly: true,
                    ),
                    _EditProfileField(
                      label: LocaleKeys.signUpGender,
                      hint: LocaleKeys.signUpMale,
                      icon: Icons.keyboard_arrow_down_rounded,
                      readOnly: true,
                    ),
                    _EditProfileField(
                      label: LocaleKeys.signUpFullName,
                      hint: user.fullName.isEmpty
                          ? LocaleKeys.signUpEnterName
                          : user.fullName,
                    ),
                    _EditProfileField(
                      label: LocaleKeys.signUpBirthDate,
                      hint: LocaleKeys.signUpBirthDateHint,
                      icon: Icons.date_range_outlined,
                      readOnly: true,
                    ),
                    _EditProfileField(
                      label: LocaleKeys.email,
                      hint: user.email.isEmpty
                          ? LocaleKeys.signUpEnterEmail
                          : user.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    _EditProfileField(
                      label: LocaleKeys.location,
                      hint: LocaleKeys.signUpSelectLocation,
                      icon: Icons.location_on_outlined,
                      readOnly: true,
                    ),
                    _EditProfileField(
                      label: LocaleKeys.signUpCity,
                      hint: user.city.isEmpty
                          ? LocaleKeys.signUpSelectCity
                          : user.city,
                      icon: Icons.keyboard_arrow_down_rounded,
                      readOnly: true,
                    ),
                    _EditProfileField(
                      label: LocaleKeys.signUpDistrict,
                      hint: LocaleKeys.signUpSelectDistrict,
                      icon: Icons.keyboard_arrow_down_rounded,
                      readOnly: true,
                      bottomSpacing: 0,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 36.h),
              TextButton(
                onPressed: () =>
                    showChangePasswordBottomSheet(context: context),
                child: Text(
                  LocaleKeys.changePassword,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _EditProfileBottomBar(
          onSave: () => successDialog(
            context: context,
            title: LocaleKeys.dataUpdatedSuccessfully,
          ),
        ),
      ),
    );
  }
}

class _EditProfileAvatar extends StatelessWidget {
  final String userImage;

  const _EditProfileAvatar({required this.userImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 120.r,
          height: 120.r,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: ClipOval(
                  child: userImage.isEmpty
                      ? Container(
                          color: AppColors.avatarBackground,
                          padding: EdgeInsets.only(top: 14.h),
                          child: AppAssets.svg.baseSvg.userVector.svg(),
                        )
                      : CachedImage(
                          url: userImage,
                          width: 120.r,
                          height: 120.r,
                          boxShape: BoxShape.circle,
                        ),
                ),
              ),
              Positioned(
                left: 0,
                bottom: 20.h,
                child: Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: const BoxDecoration(
                    color: AppColors.avatarCameraIcon,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: AppColors.white,
                    size: 20.r,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          LocaleKeys.signUpOptional,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.hintText,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _EditProfileField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData? icon;
  final bool readOnly;
  final TextInputType? keyboardType;
  final double bottomSpacing;

  const _EditProfileField({
    required this.label,
    required this.hint,
    this.icon,
    this.readOnly = false,
    this.keyboardType,
    this.bottomSpacing = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 56.h,
            child: TextFormField(
              initialValue: hint,
              readOnly: readOnly,
              keyboardType: keyboardType,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: AppColors.hintText,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.fieldFillColor,
                contentPadding: EdgeInsets.symmetric(horizontal: 22.w),
                border: _border,
                enabledBorder: _border,
                focusedBorder: _border,
                prefixIcon: icon == null
                    ? null
                    : Icon(icon, color: AppColors.hintText, size: 24.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder get _border {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),
      borderSide: BorderSide.none,
    );
  }
}

class _EditProfileBottomBar extends StatelessWidget {
  final VoidCallback onSave;

  const _EditProfileBottomBar({required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 17.h, 24.w, 17.h),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .04),
            blurRadius: 12.r,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: DefaultButton(
          title: LocaleKeys.saveChanges,
          height: 56.h,
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(28.r),
          onTap: onSave,
        ),
      ),
    );
  }
}
