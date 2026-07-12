part of '../imports/view_imports.dart';

class ChangePhoneScreen extends StatelessWidget {
  const ChangePhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChangePhoneSendCodeCubit(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.authTabSelected,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppbar(title: LocaleKeys.settingsChangePhone),
          backgroundColor: AppColors.scaffoldBackground,
          body: const _ChangePhoneBody(),
        ),
      ),
    );
  }
}

class _ChangePhoneBody extends StatefulWidget {
  const _ChangePhoneBody();

  @override
  State<_ChangePhoneBody> createState() => _ChangePhoneBodyState();
}

class _ChangePhoneBodyState extends State<_ChangePhoneBody> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    await context.read<ChangePhoneSendCodeCubit>().sendCode(
      _phoneController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 20.h),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(minHeight: 679.h),
                padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 28.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.contactCardShadow,
                      blurRadius: 62.r,
                      offset: Offset.zero,
                    ),
                  ],
                ),
                child: CustomPhoneField(
                  controller: _phoneController,
                  title: LocaleKeys.newPhone,
                  hint: LocaleKeys.pleaseEnterYourPhoneNumber,
                  textInputAction: TextInputAction.done,
                  titleStyle: const TextStyle().setBlackColor.s16.medium,
                  validator: (value) => Validators.validatePhone(
                    value,
                    fieldTitle: LocaleKeys.newPhone,
                  ),
                ),
              ),
            ),
          ),
          _ChangePhoneBottomBar(onConfirm: _confirm),
        ],
      ),
    );
  }
}

class _ChangePhoneBottomBar extends StatelessWidget {
  final Future<void> Function() onConfirm;

  const _ChangePhoneBottomBar({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<ChangePhoneSendCodeCubit>().isLoading;

    return Container(
      height: 91.h,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 18.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: const Border(
          top: BorderSide(color: AppColors.contactBottomBarBorder),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.contactBottomBarShadow,
            blurRadius: 6.r,
            offset: Offset(0, -4.h),
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
        onTap: onConfirm,
      ),
    );
  }
}
