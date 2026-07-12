part of '../../imports/view_imports.dart';

class _LoginFormCard extends StatelessWidget {
  final LoginParams params;
  final _LoginTab selectedTab;
  final ValueChanged<_LoginTab> onTabChanged;

  const _LoginFormCard({
    required this.params,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginCubit>().state;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW16,
        vertical: AppPadding.pH20,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppCircular.r20 + 4.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 55.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: _LoginLogo()),
          AppSize.sH40.szH,
          _LoginTabs(selectedTab: selectedTab, onChanged: onTabChanged),
          AppSize.sH28.szH,
          _LoginIdentifierField(params: params, selectedTab: selectedTab),
          AppSize.sH20.szH,
          _LoginPasswordField(params: params),
          AppSize.sH12.szH,
          const _ForgotPasswordButton(),
          AppSize.sH14.szH,
          LoadingButton(
            title: LocaleKeys.login,
            height: AppSize.sH56,
            borderRadius: AppCircular.infinity,
            color: AppColors.primary,
            isDissabled: state.status.isLoading,
            onTap: () => context.read<LoginCubit>().login(params),
          ),
          AppSize.sH28.szH,
          const _RegisterPrompt(),
        ],
      ),
    );
  }
}

class _LoginIdentifierField extends StatelessWidget {
  final LoginParams params;
  final _LoginTab selectedTab;

  const _LoginIdentifierField({
    required this.params,
    required this.selectedTab,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedTab == _LoginTab.phone) {
      return CustomPhoneField(
        controller: params.phoneController,
        textInputAction: TextInputAction.next,
        showTitle: true,
        title: LocaleKeys.phoneNumber,
      );
    }

    return CustomTextFiled(
      controller: params.emailController,
      hint: LocaleKeys.signUpEnterEmail,
      title: LocaleKeys.email,
      isOptional: true,
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      borderRadius: BorderRadius.circular(AppCircular.r15 + 1.r),
      validator: (value) =>
          Validators.validateEmail(value, fieldTitle: LocaleKeys.email),
    );
  }
}

class _LoginPasswordField extends StatelessWidget {
  final LoginParams params;

  const _LoginPasswordField({required this.params});

  @override
  Widget build(BuildContext context) {
    return CustomTextFiled(
      suffixIcon: AppAssets.svg.baseSvg.circlePassword.svg(),
      controller: params.passwordController,
      hint: LocaleKeys.pleaseEnterYourPassword,
      title: LocaleKeys.password,
      isOptional: true,
      isPassword: true,
      textInputType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      borderRadius: BorderRadius.circular(AppCircular.r15 + 1.r),
      validator: (value) =>
          Validators.validateEmpty(value, fieldTitle: LocaleKeys.password),
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: TextButton(
        onPressed: () => Go.to(const ResetPasswordScreen()),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size(AppSize.sW40, AppSize.sH35),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          LocaleKeys.forgotPassword.tr(context: context),
          style: const TextStyle().setHintColor.s14.regular,
        ),
      ),
    );
  }
}

class _RegisterPrompt extends StatelessWidget {
  const _RegisterPrompt();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.doNotHaveAnAccount.tr(context: context),
          style: const TextStyle().setHintColor.s14.regular,
        ),
        TextButton(
          onPressed: () => Go.toNamed(NamedRoutes.signUp),
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.pW4),
            minimumSize: Size(AppSize.sW40, AppSize.sH35),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            LocaleKeys.register.tr(context: context),
            style: const TextStyle()
                .setColor(AppColors.authLinkText)
                .s16
                .medium,
          ),
        ),
      ],
    );
  }
}
