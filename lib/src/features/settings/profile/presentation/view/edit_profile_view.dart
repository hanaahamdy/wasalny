part of '../imports/view_imports.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProfileCubit()),
        BlocProvider(create: (_) => CitiesCubit()..fetchInitialData()),
        BlocProvider(create: (_) => DistrictsCubit()),
      ],
      child: const _EditProfileContent(),
    );
  }
}

class _EditProfileContent extends StatefulWidget {
  const _EditProfileContent();

  @override
  State<_EditProfileContent> createState() => _EditProfileContentState();
}

class _EditProfileContentState extends State<_EditProfileContent> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullNameController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _emailController;
  late final TextEditingController _locationController;
  Gender? _gender;
  CityEntity? _city;
  DistrictEntity? _district;
  late final String _initialCityName;
  late final String _initialDistrictName;
  bool _didResolveInitialCity = false;
  bool _didResolveInitialDistrict = false;
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    final user = UserCubit.instance.user;
    _fullNameController = TextEditingController(text: user.fullName);
    _birthDateController = TextEditingController(text: user.birthDate);
    _emailController = TextEditingController(text: user.email);
    _locationController = TextEditingController(text: user.location);
    _gender = Gender.fromValue(user.gender);
    _initialCityName = user.city;
    _initialDistrictName = user.district;
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                    ProfileImagePicker(
                      image: _profileImage,
                      imageUrl: user.image,
                      onImageSelected: (image) {
                        setState(() => _profileImage = image);
                      },
                    ),
                    SizedBox(height: 24.h),
                    AppDropdown<Gender>(
                      label: LocaleKeys.signUpGender,
                      hint: LocaleKeys.selectAnOption,
                      value: _gender,
                      items: Gender.values,
                      itemAsString: (gender) => gender.label,
                      onChanged: (gender) {
                        if (gender == null) return;
                        setState(() => _gender = gender);
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
                      validator: (value) => Validators.validateName(
                        value,
                        fieldTitle: LocaleKeys.signUpFullName,
                      ),
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
                      onTap: _selectBirthDate,
                      validator: (value) => Validators.validateEmpty(
                        value,
                        fieldTitle: LocaleKeys.signUpBirthDate,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CustomTextFiled(
                      title: '${LocaleKeys.email} ${LocaleKeys.signUpOptional}',
                      hint: LocaleKeys.signUpEnterEmail,
                      controller: _emailController,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      borderRadius: BorderRadius.circular(16.r),
                      validator: (value) => Validators.validateEmail(
                        value,
                        fieldTitle: LocaleKeys.email,
                      ),
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
                    BlocConsumer<
                      CitiesCubit,
                      AsyncState<PaginatedData<CityEntity>>
                    >(
                      listener: _resolveInitialCity,
                      builder: (context, state) => AppDropdown<CityEntity>(
                        label: LocaleKeys.signUpCity,
                        hint: LocaleKeys.signUpSelectCity,
                        value: _city,
                        items: state.data.items,
                        isLoading: state.isLoading,
                        isLoadingMore: state.isLoadingMore,
                        hasMoreItems: !state.data.meta.isLastPage,
                        onLoadMore: context.read<CitiesCubit>().loadMore,
                        isFailer: state.isError,
                        itemAsString: (city) => city.name,
                        onChanged: _onCityChanged,
                        height: 56.h,
                        borderRadius: BorderRadius.circular(16.r),
                        validator: (city) => Validators.validateDropDown(
                          city,
                          fieldTitle: LocaleKeys.signUpCity,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    BlocConsumer<
                      DistrictsCubit,
                      AsyncState<List<DistrictEntity>>
                    >(
                      listener: _resolveInitialDistrict,
                      builder: (context, state) => AppDropdown<DistrictEntity>(
                        label: LocaleKeys.signUpDistrict,
                        hint: LocaleKeys.signUpSelectDistrict,
                        value: _district,
                        items: state.data,
                        isLoading: state.isLoading,
                        isFailer: state.isError,
                        readonly: _city == null,
                        itemAsString: (district) => district.name,
                        onChanged: (district) =>
                            setState(() => _district = district),
                        height: 56.h,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _EditProfileBottomBar(
        onChangePassword: () => showChangePasswordBottomSheet(context: context),
        onSave: _saveProfile,
      ),
    );
  }

  Future<void> _selectBirthDate() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final initialDate = DateTime.tryParse(_birthDateController.text);
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate != null && !initialDate.isAfter(today)
          ? initialDate
          : today,
      firstDate: DateTime(today.year - 100),
      lastDate: today,
    );
    if (selectedDate == null) return;
    _birthDateController.text =
        '${selectedDate.year.toString().padLeft(4, '0')}-'
        '${selectedDate.month.toString().padLeft(2, '0')}-'
        '${selectedDate.day.toString().padLeft(2, '0')}';
  }

  void _resolveInitialCity(
    BuildContext context,
    AsyncState<PaginatedData<CityEntity>> state,
  ) {
    if (_didResolveInitialCity || state.isLoading || state.isLoadingMore) {
      return;
    }
    if (_initialCityName.isEmpty) return;

    final city = state.data.items
        .where((item) => item.name == _initialCityName)
        .firstOrNull;
    if (city == null) {
      if (!state.data.meta.isLastPage) {
        context.read<CitiesCubit>().loadMore();
      } else {
        _didResolveInitialCity = true;
      }
      return;
    }
    _didResolveInitialCity = true;
    setState(() => _city = city);
    context.read<DistrictsCubit>().fetchDistricts(city.id);
  }

  void _resolveInitialDistrict(
    BuildContext context,
    AsyncState<List<DistrictEntity>> state,
  ) {
    if (_didResolveInitialDistrict || state.isLoading) return;
    _didResolveInitialDistrict = true;
    if (_initialDistrictName.isEmpty) return;

    final district = state.data
        .where((item) => item.name == _initialDistrictName)
        .firstOrNull;
    if (district != null) setState(() => _district = district);
  }

  void _onCityChanged(CityEntity? city) {
    setState(() {
      _city = city;
      _district = null;
      _didResolveInitialDistrict = true;
    });
    if (city == null) {
      context.read<DistrictsCubit>().clear();
    } else {
      context.read<DistrictsCubit>().fetchDistricts(city.id);
    }
  }

  Future<void> _saveProfile() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final params = UpdateProfileParams(
      fullName: _fullNameController.text.trim(),
      birthDate: _birthDateController.text.trim(),
      email: _emailController.text.trim(),
      location: _locationController.text.trim(),
      gender: _gender?.value ?? UserCubit.instance.user.gender,
      cityId: _city?.id,
      districtId: _district?.id,
      cityName: _city?.name,
      districtName: _district?.name,
      image: _profileImage,
    );
    final success = await context.read<ProfileCubit>().updateProfile(params);
    if (!success || !mounted) return;
    await successDialog(
      context: context,
      title: LocaleKeys.dataUpdatedSuccessfully,
    );
  }
}

class _EditProfileBottomBar extends StatelessWidget {
  final Future<void> Function() onSave;
  final VoidCallback onChangePassword;

  const _EditProfileBottomBar({
    required this.onSave,
    required this.onChangePassword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: onChangePassword,
              style: TextButton.styleFrom(
                minimumSize: Size(double.infinity, 48.h),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                LocaleKeys.changePassword,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Divider(height: 1.h, color: AppColors.inputBorder),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 17.h, 24.w, 17.h),
              child: LoadingButton(
                title: LocaleKeys.saveChanges,
                height: 56.h,
                color: AppColors.primary,
                borderRadius: 28.r,
                onTap: onSave,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
