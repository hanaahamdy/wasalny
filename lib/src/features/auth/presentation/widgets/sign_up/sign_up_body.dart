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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Form(
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
                    const _AvatarPicker(),
                    AppSize.sH24.szH,
                    CustomPhoneField(
                      controller: params.phoneController,
                      textInputAction: TextInputAction.next,
                      title: LocaleKeys.phoneNumber,
                      countryCodeAtStart: true,
                    ),
                    AppSize.sH20.szH,
                    _SignUpSelectField(
                      title: 'النوع',
                      value: params.type,
                      onTap: () {},
                    ),
                    AppSize.sH20.szH,
                    _SignUpSelectField(
                      title: 'الجنس',
                      value: params.gender,
                      onTap: () {},
                    ),
                    AppSize.sH20.szH,
                    _SignUpInputField(
                      title: 'الاسم بالكامل',
                      hint: 'ادخل الاسم',
                      controller: params.fullNameController,
                      textInputAction: TextInputAction.next,
                      validator: (value) => Validators.validateEmpty(
                        value,
                        fieldTitle: 'الاسم بالكامل',
                      ),
                    ),
                    AppSize.sH20.szH,
                    _SignUpInputField(
                      title: 'العمر او تاريخ الميلاد',
                      hint: 'ادخل العمر   او اختر من القائمة',
                      controller: params.birthDateController,
                      textInputType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                      prefixIcon: Icons.edit_calendar_outlined,
                      validator: (value) => Validators.validateEmpty(
                        value,
                        fieldTitle: 'العمر او تاريخ الميلاد',
                      ),
                    ),
                    AppSize.sH20.szH,
                    _SignUpInputField(
                      title: 'البريد الالكتروني',
                      hint: 'ادخل البريد',
                      controller: params.emailController,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) => Validators.validateEmail(
                        value,
                        fieldTitle: LocaleKeys.email,
                      ),
                    ),
                    AppSize.sH20.szH,
                    _SignUpInputField(
                      title: 'الموقع',
                      hint: 'تحديد الموقع',
                      controller: params.locationController,
                      textInputAction: TextInputAction.next,
                      prefixIcon: Icons.location_on_outlined,
                      validator: (value) =>
                          Validators.validateEmpty(value, fieldTitle: 'الموقع'),
                    ),
                    AppSize.sH20.szH,
                    _SignUpSelectField(
                      title: 'المدينة',
                      value: params.city ?? 'تحديد المدينة',
                      onTap: () {},
                    ),
                    AppSize.sH20.szH,
                    _SignUpSelectField(
                      title: 'الحي',
                      value: params.district ?? 'تحديد الحي',
                      onTap: () {},
                    ),
                    AppSize.sH20.szH,
                    _SignUpInputField(
                      title: LocaleKeys.password,
                      hint: 'ادخل كلمة المرور',
                      controller: params.passwordController,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      validator: (value) => Validators.validatePassword(
                        value,
                        fieldTitle: LocaleKeys.password,
                      ),
                    ),
                    AppSize.sH20.szH,
                    _SignUpInputField(
                      title: LocaleKeys.confirmPassword,
                      hint: 'ادخل كلمة المرور',
                      controller: params.confirmPasswordController,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                      validator: (value) => Validators.validatePasswordConfirm(
                        value,
                        params.passwordController.text,
                        fieldTitle: LocaleKeys.confirmPassword,
                      ),
                    ),
                    AppSize.sH18.szH,
                    _TermsRow(
                      isChecked: params.acceptedTerms,
                      onChanged: () {
                        setState(() {
                          params.acceptedTerms = !params.acceptedTerms;
                        });
                      },
                    ),
                    AppSize.sH16.szH,
                    LoadingButton(
                      title: LocaleKeys.createAccount,
                      height: AppSize.sH56,
                      borderRadius: AppCircular.infinity,
                      color: AppColors.primary,
                      onTap: () async {
                        params.validate();
                      },
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
      ),
    );
  }
}
