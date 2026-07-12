part of '../../imports/view_imports.dart';

Future<void> showChangePhoneBottomSheet({BuildContext? context}) {
  return showDefaultBottomSheet(
    context: context ?? Go.context,
    child: BlocProvider(
      create: (_) => ChangePhonePasswordCubit(),
      child: const _ChangePhoneBottomSheet(),
    ),
  );
}

class _ChangePhoneBottomSheet extends StatefulWidget {
  const _ChangePhoneBottomSheet();

  @override
  State<_ChangePhoneBottomSheet> createState() =>
      _ChangePhoneBottomSheetState();
}

class _ChangePhoneBottomSheetState extends State<_ChangePhoneBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    await context.read<ChangePhonePasswordCubit>().checkPassword(
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            LocaleKeys.settingsChangePhone,
            style: const TextStyle().setBlackColor.s18.medium,
          ),
          SizedBox(height: 17.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: CustomTextFiled(
              controller: _passwordController,
              title: LocaleKeys.currentPassword,
              hint: LocaleKeys.pleaseEnterYourPassword,
              textInputType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              isPassword: true,
              fillColor: AppColors.fieldFillColor,
              borderRadius: BorderRadius.circular(24.r),
              suffixIcon: AppAssets.svg.baseSvg.circlePassword.svg(
                width: 24.r,
                height: 24.r,
              ),
              validator: (value) => Validators.validateEmpty(
                value,
                fieldTitle: LocaleKeys.currentPassword,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10.w, 16.h, 10.w, 0),
            decoration: const BoxDecoration(
              color: AppColors.white,
              border: Border(
                top: BorderSide(color: AppColors.contactBottomBarBorder),
              ),
            ),
            child: LoadingButton(
              title: LocaleKeys.confirm,
              color: AppColors.primary,
              textColor: AppColors.white,
              height: 56.h,
              borderRadius: 50.r,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              onTap: _confirm,
            ),
          ),
        ],
      ),
    );
  }
}
