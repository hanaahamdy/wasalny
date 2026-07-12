part of '../../imports/view_imports.dart';

Future<void> showChangePasswordBottomSheet({BuildContext? context}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: AppColors.transparent,
    context: context ?? Go.context,
    builder: (context) => BlocProvider(
      create: (_) => ProfileChangePasswordCubit(),
      child: const _ChangePasswordSheetFrame(),
    ),
  );
}

class _ChangePasswordSheetFrame extends StatelessWidget {
  const _ChangePasswordSheetFrame();

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SingleChildScrollView(
        child: Container(
          width: 1.sw,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            boxShadow: [
              BoxShadow(
                color: AppColors.changePhoneSheetShadow.withValues(alpha: .13),
                offset: Offset(0, 1.h),
                blurRadius: 3.r,
              ),
              BoxShadow(
                color: AppColors.changePhoneSheetShadow.withValues(alpha: .08),
                offset: Offset(0, 30.h),
                blurRadius: 84.r,
              ),
            ],
          ),
          child: const _ChangePasswordBottomSheet(),
        ),
      ),
    );
  }
}

class _ChangePasswordBottomSheet extends StatefulWidget {
  const _ChangePasswordBottomSheet();

  @override
  State<_ChangePasswordBottomSheet> createState() =>
      _ChangePasswordBottomSheetState();
}

class _ChangePasswordBottomSheetState
    extends State<_ChangePasswordBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    await context.read<ProfileChangePasswordCubit>().changePassword(
      currentPassword: _currentPasswordController.text,
      password: _newPasswordController.text,
      confirmPassword: _confirmPasswordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(
      (ProfileChangePasswordCubit cubit) => cubit.state.status.isLoading,
    );

    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8.h),
            Container(
              width: 64.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.changePhoneSheetHandle,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              LocaleKeys.changePassword,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  _PasswordSheetField(
                    controller: _currentPasswordController,
                    title: LocaleKeys.currentPassword,
                    validator: (value) => Validators.validateEmpty(
                      value,
                      fieldTitle: LocaleKeys.currentPassword,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _PasswordSheetField(
                    controller: _newPasswordController,
                    title: LocaleKeys.newPassword,
                    validator: (value) => Validators.validatePassword(
                      value,
                      fieldTitle: LocaleKeys.newPassword,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _PasswordSheetField(
                    controller: _confirmPasswordController,
                    title: LocaleKeys.confirmPassword,
                    validator: (value) => Validators.validatePasswordConfirm(
                      value,
                      _newPasswordController.text,
                      fieldTitle: LocaleKeys.confirmPassword,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 22.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                24.w,
                17.h,
                24.w,
                MediaQuery.paddingOf(context).bottom == 0
                    ? 18.h
                    : MediaQuery.paddingOf(context).bottom,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: const Border(
                  top: BorderSide(color: AppColors.contactBottomBarBorder),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: .06),
                    offset: Offset(0, -4.h),
                    blurRadius: 6.r,
                  ),
                ],
              ),
              child: LoadingButton(
                title: LocaleKeys.confirm,
                color: AppColors.primary,
                textColor: AppColors.white,
                height: 56.h,
                borderRadius: 50.r,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                isDissabled: isLoading,
                onTap: _confirm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordSheetField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String? Function(String?) validator;

  const _PasswordSheetField({
    required this.controller,
    required this.title,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 56.h,
          child: TextFormField(
            controller: controller,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            textAlign: TextAlign.right,
            validator: validator,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.fieldFillColor,
              hintText: LocaleKeys.pleaseEnterYourPassword,
              hintStyle: TextStyle(
                color: AppColors.hintText,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
              border: _border,
              enabledBorder: _border,
              focusedBorder: _border,
              errorBorder: _border,
              focusedErrorBorder: _border,
              suffixIcon: Padding(
                padding: EdgeInsetsDirectional.only(end: 16.w),
                child: AppAssets.svg.baseSvg.circlePassword.svg(
                  width: 24.r,
                  height: 24.r,
                ),
              ),
              suffixIconConstraints: BoxConstraints(
                minWidth: 56.w,
                minHeight: 56.h,
              ),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder get _border {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24.r),
      borderSide: BorderSide.none,
    );
  }
}
