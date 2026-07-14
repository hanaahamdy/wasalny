part of '../../imports/view_imports.dart';

class _SignUpBody extends StatefulWidget {
  const _SignUpBody();

  @override
  State<_SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<_SignUpBody> {
  final SignUpParams params = SignUpParams();

  @override
  void dispose() {
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
                    valueListenable: params.avatarImageNotifier,
                    builder: (context, image, _) {
                      return _AvatarPicker(
                        image: image,
                        onImagePicked: (image) {
                          params.avatarImageNotifier.value = image;
                        },
                      );
                    },
                  ),
                  AppSize.sH24.szH,
                  CustomPhoneField(
                    controller: params.phoneController,
                    textInputAction: TextInputAction.next,
                    title: LocaleKeys.phoneNumber,
                  ),
                  AppSize.sH20.szH,
                  CustomTextFiled(
                    title: LocaleKeys.signUpType,
                    hint: params.type,
                    controller: null,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: null,
                    onTap: () {},
                    readOnly: true,
                    borderRadius: BorderRadius.circular(16),
                    suffixIcon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.hintText,
                      size: 24,
                    ),
                  ),
                  AppSize.sH20.szH,
                  AppDropdown<String>(
                    label: LocaleKeys.signUpGender,
                    hint: params.gender,
                    value: params.gender,
                    items: params.genderOptions,
                    itemAsString: (item) => item,
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        params.gender = value;
                      });
                    },
                    borderRadius: BorderRadius.circular(16),
                    validator: (value) => Validators.validateDropDown(
                      value,
                      fieldTitle: LocaleKeys.signUpGender,
                    ),
                  ),
                  AppSize.sH20.szH,
                  AppDropdown<String>(
                    label: LocaleKeys.signUpFullName,
                    hint: LocaleKeys.signUpEnterName,
                    value: params.fullNameController.text.isEmpty
                        ? null
                        : params.fullNameController.text,
                    items: params.fullNameOptions,
                    itemAsString: (item) => item,
                    onChanged: (value) {
                      params.fullNameController.text = value ?? '';
                    },
                    borderRadius: BorderRadius.circular(16),
                    validator: (value) => Validators.validateDropDown(
                      value,
                      fieldTitle: LocaleKeys.signUpFullName,
                    ),
                  ),
                  AppSize.sH20.szH,
                  AppDropdown<String>(
                    label: LocaleKeys.signUpBirthDate,
                    hint: LocaleKeys.signUpBirthDateHint,
                    value: params.birthDateController.text.isEmpty
                        ? null
                        : params.birthDateController.text,
                    items: params.birthDateOptions,
                    itemAsString: (item) => item,
                    onChanged: (value) {
                      params.birthDateController.text = value ?? '';
                    },
                    borderRadius: BorderRadius.circular(16),
                    validator: (value) => Validators.validateDropDown(
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
                    onLocationSelected: (_) {},
                  ),
                  AppSize.sH20.szH,
                  AppDropdown<String>(
                    label: LocaleKeys.signUpCity,
                    hint: params.city ?? LocaleKeys.signUpSelectCity,
                    value: params.city,
                    items: params.cityOptions,
                    itemAsString: (item) => item,
                    onChanged: (value) {
                      setState(() {
                        params.city = value;
                        params.district = null;
                      });
                    },
                    borderRadius: BorderRadius.circular(16),
                    validator: (value) => Validators.validateDropDown(
                      value,
                      fieldTitle: LocaleKeys.signUpCity,
                    ),
                  ),
                  AppSize.sH20.szH,
                  AppDropdown<String>(
                    label: LocaleKeys.signUpDistrict,
                    hint: params.district ?? LocaleKeys.signUpSelectDistrict,
                    value: params.district,
                    items: params.districtOptions,
                    itemAsString: (item) => item,
                    onChanged: (value) {
                      setState(() {
                        params.district = value;
                      });
                    },
                    borderRadius: BorderRadius.circular(16),
                    validator: (value) => Validators.validateDropDown(
                      value,
                      fieldTitle: LocaleKeys.signUpDistrict,
                    ),
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
                  ValueListenableBuilder<bool>(
                    valueListenable: params.acceptedTermsNotifier,
                    builder: (context, acceptedTerms, _) {
                      return _TermsRow(
                        isChecked: acceptedTerms,
                        onChanged: () {
                          params.acceptedTermsNotifier.value = !acceptedTerms;
                        },
                      );
                    },
                  ),
                  AppSize.sH16.szH,
                  LoadingButton(
                    title: LocaleKeys.createAccount,
                    height: AppSize.sH56,
                    borderRadius: AppCircular.infinity,
                    color: AppColors.primary,
                    isDissabled: registerState.isLoading,
                    onTap: () =>
                        context.read<RegisterCubit>().register(params),
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
