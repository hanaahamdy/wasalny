part of '../../imports/view_imports.dart';

class _ResetPasswordBody extends StatefulWidget {
  const _ResetPasswordBody();

  @override
  State<_ResetPasswordBody> createState() => _ResetPasswordBodyState();
}

class _ResetPasswordBodyState extends State<_ResetPasswordBody> {
  final ResetPasswordParams params = ResetPasswordParams();

  @override
  void dispose() {
    params.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: params.formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pW20,
          vertical: AppPadding.pH16,
        ),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _ResetPasswordHeader(),
            AppSize.sH20.szH,
            Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.sizeOf(context).height * .62,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.pW16,
                vertical: AppPadding.pH20,
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
                  Center(child: _LoginLogo()),
                  AppSize.sH40.szH,
                  CustomPhoneField(
                    controller: params.phoneController,
                    textInputAction: TextInputAction.done,
                    title: LocaleKeys.phoneNumber,
                    hint: LocaleKeys.pleaseEnterYourPhoneNumber,
                  ),
                  AppSize.sH24.szH,
                  LoadingButton(
                    title: LocaleKeys.confirm,
                    height: AppSize.sH56,
                    borderRadius: AppCircular.infinity,
                    color: AppColors.primary,
                    onTap: () async {
                      if (!params.validate()) return;

                      await Go.to(
                        OtpVerificationScreen(
                          phone: params.phoneController.text.trim(),
                          purpose: OtpPurpose.resetPassword,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResetPasswordHeader extends StatelessWidget {
  const _ResetPasswordHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.forgotPassword.replaceAll('؟', '').replaceAll('?', ''),
          style: const TextStyle().setMainTextColor.s20.semiBold,
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
