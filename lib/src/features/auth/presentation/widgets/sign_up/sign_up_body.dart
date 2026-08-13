part of '../../imports/view_imports.dart';

class _SignUpBody extends StatefulWidget {
  const _SignUpBody();

  @override
  State<_SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<_SignUpBody> {
  final SignUpParams params = SignUpParams();
  final ValueNotifier<File?> _imageNotifier = ValueNotifier(null);
  final ValueNotifier<Gender?> _genderNotifier = ValueNotifier(null);
  final ValueNotifier<CityEntity?> _cityNotifier = ValueNotifier(null);
  final ValueNotifier<DistrictEntity?> _districtNotifier = ValueNotifier(null);

  @override
  void dispose() {
    _imageNotifier.dispose();
    _genderNotifier.dispose();
    _cityNotifier.dispose();
    _districtNotifier.dispose();
    params.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerState = context.watch<RegisterCubit>().state;
    return Form(
      key: params.formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pW14,
          vertical: AppPadding.pH16,
        ),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _SignUpHeader(),
            AppSize.sH16.szH,
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.pW10,
                vertical: AppPadding.pH28,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: .06),
                    blurRadius: 55,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ValueListenableBuilder<File?>(
                    valueListenable: _imageNotifier,
                    builder: (context, image, _) => ProfileImagePicker(
                      image: image,
                      onImageSelected: (image) {
                        params.image = image;
                        _imageNotifier.value = image;
                      },
                      label: Text.rich(
                        TextSpan(
                          text: '${LocaleKeys.signUpProfilePicture} ',
                          style: const TextStyle().setMainTextColor.s14.medium,
                          children: [
                            TextSpan(
                              text: LocaleKeys.signUpOptional,
                              style: const TextStyle().setHintColor.s12.regular,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  AppSize.sH24.szH,
                  CustomPhoneField(
                    controller: params.phoneController,
                    textInputAction: TextInputAction.next,
                    title: LocaleKeys.phoneNumber,
                  ),
                  AppSize.sH20.szH,
                  ValueListenableBuilder<Gender?>(
                    valueListenable: _genderNotifier,
                    builder: (context, gender, _) => AppDropdown<Gender>(
                      label: LocaleKeys.signUpGender,
                      hint: LocaleKeys.selectAnOption,
                      value: gender,
                      items: Gender.values,
                      showHeader: true,
                      showSearchBox: false,
                      itemAsString: (item) => item.label,
                      onChanged: (gender) {
                        params.gender = gender;
                        _genderNotifier.value = gender;
                      },
                      borderRadius: BorderRadius.circular(16),
                      validator: (value) => Validators.validateDropDown(
                        value,
                        fieldTitle: LocaleKeys.signUpGender,
                      ),
                    ),
                  ),
                  AppSize.sH20.szH,
                  CustomTextFiled(
                    title: LocaleKeys.signUpFullName,
                    hint: LocaleKeys.signUpEnterName,
                    controller: params.fullNameController,
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    borderRadius: BorderRadius.circular(16),
                    validator: (value) => Validators.validateName(
                      value,
                      fieldTitle: LocaleKeys.signUpFullName,
                    ),
                  ),
                  AppSize.sH20.szH,
                  CustomTextFiled(
                    title: LocaleKeys.signUpBirthDate,
                    hint: LocaleKeys.signUpBirthDateHint,
                    controller: params.birthDateController,
                    textInputType: TextInputType.datetime,
                    textInputAction: TextInputAction.next,
                    readOnly: true,
                    onTap: () async {
                      final now = DateTime.now();
                      final today = DateTime(now.year, now.month, now.day);
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: today,
                        firstDate: DateTime(today.year - 100),
                        lastDate: today,
                      );
                      if (selectedDate == null) return;
                      params.birthDateController.text =
                          '${selectedDate.year.toString().padLeft(4, '0')}-'
                          '${selectedDate.month.toString().padLeft(2, '0')}-'
                          '${selectedDate.day.toString().padLeft(2, '0')}';
                    },
                    borderRadius: BorderRadius.circular(16),
                    validator: (value) => Validators.validateEmpty(
                      value,
                      fieldTitle: LocaleKeys.signUpBirthDate,
                    ),
                  ),
                  AppSize.sH20.szH,
                  CustomTextFiled(
                    title: LocaleKeys.email,
                    hint: LocaleKeys.signUpEnterEmail,
                    controller: params.emailController,
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    borderRadius: BorderRadius.circular(16),
                    validator: (value) => Validators.validateEmail(
                      value,
                      fieldTitle: LocaleKeys.email,
                    ),
                  ),
                  AppSize.sH20.szH,
                  LocationTextField(
                    controller: params.locationController,
                    onLocationSelected: (location) {
                      params.latitude = location.position?.latitude;
                      params.longitude = location.position?.longitude;
                      params.locationController.text =
                          location.descriptiveLocation;
                    },
                  ),
                  AppSize.sH20.szH,
                  BlocBuilder<
                    CitiesCubit,
                    AsyncState<PaginatedData<CityEntity>>
                  >(
                    builder: (context, state) {
                      final cities = state.data.items;
                      return ValueListenableBuilder<CityEntity?>(
                        valueListenable: _cityNotifier,
                        builder: (context, selectedCity, _) =>
                            AppDropdown<CityEntity>(
                              label: LocaleKeys.signUpCity,
                              hint: LocaleKeys.signUpSelectCity,
                              value: selectedCity,
                              items: cities,
                              isLoading: state.isLoading,
                              isLoadingMore: state.isLoadingMore,
                              hasMoreItems: !state.data.meta.isLastPage,
                              onLoadMore: context.read<CitiesCubit>().loadMore,
                              isFailer: state.isError,
                              itemAsString: (city) => city.name,
                              onChanged: (city) {
                                params.cityId = city?.id.toString();
                                params.districtId = null;
                                _cityNotifier.value = city;
                                _districtNotifier.value = null;
                                if (city == null) {
                                  context.read<DistrictsCubit>().clear();
                                } else {
                                  context.read<DistrictsCubit>().fetchDistricts(
                                    city.id,
                                  );
                                }
                              },
                              borderRadius: BorderRadius.circular(16),
                              validator: (city) => Validators.validateDropDown(
                                city,
                                fieldTitle: LocaleKeys.signUpCity,
                              ),
                            ),
                      );
                    },
                  ),
                  AppSize.sH20.szH,
                  BlocBuilder<DistrictsCubit, AsyncState<List<DistrictEntity>>>(
                    builder: (context, state) {
                      return ValueListenableBuilder<CityEntity?>(
                        valueListenable: _cityNotifier,
                        builder: (context, city, _) =>
                            ValueListenableBuilder<DistrictEntity?>(
                              valueListenable: _districtNotifier,
                              builder: (context, selectedDistrict, _) =>
                                  AppDropdown<DistrictEntity>(
                                    label: LocaleKeys.signUpDistrict,
                                    hint: LocaleKeys.signUpSelectDistrict,
                                    isOptional: true,
                                    value: selectedDistrict,
                                    items: state.data,
                                    isLoading: state.isLoading,
                                    isFailer: state.isError,
                                    readonly: city == null,
                                    fillColor: AppColors.fieldFillColor,
                                    itemAsString: (district) => district.name,
                                    onChanged: (district) {
                                      params.districtId = district?.id
                                          .toString();
                                      _districtNotifier.value = district;
                                    },
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                            ),
                      );
                    },
                  ),
                  AppSize.sH20.szH,
                  CustomTextFiled(
                    title: LocaleKeys.password,
                    hint: LocaleKeys.pleaseEnterYourPassword,
                    controller: params.passwordController,
                    textInputType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    borderRadius: BorderRadius.circular(16),
                    suffixIcon: AppAssets.svg.baseSvg.circlePassword.svg(),
                    isPassword: true,
                    validator: (value) => Validators.validatePassword(
                      value,
                      fieldTitle: LocaleKeys.password,
                    ),
                  ),
                  AppSize.sH20.szH,
                  CustomTextFiled(
                    isPassword: true,
                    title: LocaleKeys.confirmPassword,
                    hint: LocaleKeys.pleaseEnterYourPassword,
                    controller: params.confirmPasswordController,
                    textInputType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    borderRadius: BorderRadius.circular(16),

                    suffixIcon: AppAssets.svg.baseSvg.circlePassword.svg(),
                    validator: (value) => Validators.validatePasswordConfirm(
                      value,
                      params.passwordController.text,
                      fieldTitle: LocaleKeys.confirmPassword,
                    ),
                  ),
                  AppSize.sH18.szH,
                  const _TermsAgreementField(),
                  AppSize.sH16.szH,
                  LoadingButton(
                    title: LocaleKeys.createAccount,
                    height: AppSize.sH56,
                    borderRadius: AppCircular.infinity,
                    color: AppColors.primary,
                    isDissabled: registerState.isLoading,
                    onTap: () => context.read<RegisterCubit>().register(params),
                  ),
                  AppSize.sH22.szH,
                  const _LoginLink(),
                ],
              ),
            ),
            AppSize.sH24.szH,
          ],
        ),
      ),
    );
  }
}
