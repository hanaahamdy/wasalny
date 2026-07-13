part of '../imports/view_imports.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _emailController;
  late final TextEditingController _locationController;
  String _type = LocaleKeys.signUpPlayer;
  String _gender = LocaleKeys.signUpMale;
  String? _city;
  String? _district;

  final List<String> _typeOptions = [LocaleKeys.signUpPlayer];
  final List<String> _genderOptions = [
    LocaleKeys.signUpMale,
    LocaleKeys.signUpFemale,
  ];
  final List<String> _cityOptions = ['Riyadh', 'Jeddah', 'Cairo'];
  final List<String> _districtOptions = [
    'Al Nakheel District',
    'Al Faisaliah District',
    'Al Malqa District',
    'Nasr City',
  ];

  @override
  void initState() {
    super.initState();
    final user = UserCubit.instance.user;
    _fullNameController = TextEditingController(text: user.fullName);
    _birthDateController = TextEditingController();
    _emailController = TextEditingController(text: user.email);
    _locationController = TextEditingController();
    _city = user.city.isEmpty ? null : user.city;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = UserCubit.instance.user;

    return Scaffold(
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
                  AppDropdown<String>(
                    label: LocaleKeys.signUpType,
                    hint: LocaleKeys.signUpPlayer,
                    value: _type,
                    items: _typeOptions,
                    itemAsString: (type) => type,
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _type = value);
                    },
                    height: 56.h,
                    showSearchBox: false,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  SizedBox(height: 20.h),
                  AppDropdown<String>(
                    label: LocaleKeys.signUpGender,
                    hint: LocaleKeys.signUpMale,
                    value: _gender,
                    items: _genderOptions,
                    itemAsString: (gender) => gender,
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _gender = value);
                    },
                    height: 56.h,
                    showSearchBox: false,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  SizedBox(height: 20.h),
                  CustomTextFiled(
                    title: LocaleKeys.signUpFullName,
                    hint: LocaleKeys.signUpEnterName,
                    controller: _fullNameController,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    borderRadius: BorderRadius.circular(16.r),
                    validator: null,
                    isOptional: true,
                  ),
                  SizedBox(height: 20.h),
                  CustomTextFiled(
                    title: LocaleKeys.signUpBirthDate,
                    hint: LocaleKeys.signUpBirthDateHint,
                    controller: _birthDateController,
                    textInputType: TextInputType.datetime,
                    textInputAction: TextInputAction.next,
                    borderRadius: BorderRadius.circular(16.r),
                    suffixIcon: Icon(
                      Icons.date_range_outlined,
                      color: AppColors.hintText,
                      size: 24.r,
                    ),
                    readOnly: true,
                    validator: null,
                    isOptional: true,
                  ),
                  SizedBox(height: 20.h),
                  CustomTextFiled(
                    title: LocaleKeys.email,
                    hint: LocaleKeys.signUpEnterEmail,
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    borderRadius: BorderRadius.circular(16.r),
                    validator: null,
                    isOptional: true,
                  ),
                  SizedBox(height: 20.h),
                  CustomTextFiled(
                    title: LocaleKeys.location,
                    hint: LocaleKeys.signUpSelectLocation,
                    controller: _locationController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    borderRadius: BorderRadius.circular(16.r),
                    suffixIcon: Icon(
                      Icons.location_on_outlined,
                      color: AppColors.hintText,
                      size: 24.r,
                    ),
                    readOnly: true,
                    validator: null,
                    isOptional: true,
                  ),
                  SizedBox(height: 20.h),
                  AppDropdown<String>(
                    label: LocaleKeys.signUpCity,
                    hint: LocaleKeys.signUpSelectCity,
                    value: _city,
                    items: _cityOptions,
                    itemAsString: (city) => city,
                    onChanged: (value) {
                      setState(() {
                        _city = value;
                        _district = null;
                      });
                    },
                    height: 56.h,
                    showSearchBox: false,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  SizedBox(height: 20.h),
                  AppDropdown<String>(
                    label: LocaleKeys.signUpDistrict,
                    hint: LocaleKeys.signUpSelectDistrict,
                    value: _district,
                    items: _districtOptions,
                    itemAsString: (district) => district,
                    onChanged: (value) => setState(() => _district = value),
                    height: 56.h,
                    showSearchBox: false,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ],
              ),
            ),
            SizedBox(height: 36.h),
            TextButton(
              onPressed: () => showChangePasswordBottomSheet(context: context),
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
