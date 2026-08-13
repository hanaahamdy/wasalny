part of '../../imports/view_imports.dart';

class _ChangePasswordBody extends StatefulWidget {
  final String phone;
  final String verificationCode;

  const _ChangePasswordBody({
    required this.phone,
    required this.verificationCode,
  });

  @override
  State<_ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<_ChangePasswordBody> {
  final ResetPasswordParams params = ResetPasswordParams();

  @override
  void dispose() {
    params.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final changePasswordState = context.watch<ChangePasswordCubit>().state;

    return Form(
      key: params.formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pW24,
          vertical: AppPadding.pH14,
        ),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _ChangePasswordHeader(),
            AppSize.sH20.szH,
            _ChangePasswordCard(
              params: params,
              phone: widget.phone,
              verificationCode: widget.verificationCode,
              isLoading: changePasswordState.isLoading,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChangePasswordHeader extends StatelessWidget {
  const _ChangePasswordHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.forgotPassword.replaceAll('؟', '').replaceAll('?', ''),

          style: const TextStyle().setMainTextColor.s20.bold,
        ),
        AppSize.sH10.szH,
        Text(
          LocaleKeys.forgotPasswordSubtitle,
          style: const TextStyle().setHintColor.s12.regular,
        ),
      ],
    );
  }
}

class _ChangePasswordCard extends StatelessWidget {
  final ResetPasswordParams params;
  final String phone;
  final String verificationCode;
  final bool isLoading;

  const _ChangePasswordCard({
    required this.params,
    required this.phone,
    required this.verificationCode,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.sizeOf(context).height * .61,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW16,
        vertical: AppPadding.pH20,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r20 + 4.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .06),
            blurRadius: 55.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(child: AppLogoWidget()),
          AppSize.sH30.szH,
          CustomTextFiled(
            suffixIcon: AppAssets.svg.baseSvg.circlePassword.svg(),
            controller: params.passwordController,
            hint: LocaleKeys.pleaseEnterYourPassword,
            title: LocaleKeys.newPassword,
            isOptional: true,
            isPassword: true,
            textInputType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            borderRadius: BorderRadius.circular(AppCircular.r20),
            validator: (value) => Validators.validatePassword(
              value,
              fieldTitle: LocaleKeys.newPassword,
            ),
          ),
          AppSize.sH20.szH,
          CustomTextFiled(
            suffixIcon: AppAssets.svg.baseSvg.circlePassword.svg(),
            controller: params.confirmPasswordController,
            hint: LocaleKeys.pleaseEnterYourPassword,
            title: LocaleKeys.confirmPassword,
            isOptional: true,
            isPassword: true,
            textInputType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            borderRadius: BorderRadius.circular(AppCircular.r20),
            validator: (value) => Validators.validatePasswordConfirm(
              value,
              params.passwordController.text,
              fieldTitle: LocaleKeys.confirmPassword,
            ),
          ),
          AppSize.sH24.szH,
          LoadingButton(
            title: LocaleKeys.confirm,
            height: AppSize.sH56,
            borderRadius: AppCircular.infinity,
            color: AppColors.primary,
            isDissabled: isLoading,
            onTap: () async {
              await context.read<ChangePasswordCubit>().changePassword(
                phone: phone,
                verificationCode: verificationCode,
                params: params,
              );
            },
          ),
        ],
      ),
    );
  }
}
