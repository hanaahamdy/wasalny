part of '../imports/view_imports.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  final String otp;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => ResetPasswordCubit(email: email, otp: otp),
    child: Builder(
      builder: (context) {
        final cubit = context.read<ResetPasswordCubit>();
        return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listenWhen: (previous, current) =>
              previous.errorMessage != current.errorMessage ||
              (!previous.isSuccess && current.isSuccess),
          listener: (context, state) {
            if (state.errorMessage != null) {
              MessageUtils.showSnackBar(
                context: context,
                baseStatus: BaseStatus.error,
                message: state.errorMessage!,
              );
            } else if (state.isSuccess) {
              MessageUtils.showSnackBar(
                context: context,
                baseStatus: BaseStatus.success,
                message: state.successMessage?.isNotEmpty == true
                    ? state.successMessage!
                    : LocaleKeys.passwordResetSuccess,
              );
              Go.offAll(const LoginScreen());
            }
          },
          builder: (context, state) => AuthShell(
            child: AuthFormCard(
              formKey: cubit.formKey,
              title: LocaleKeys.resetPassword,
              subtitle: LocaleKeys.enterNewPassword,
              fields: [
                CustomTextFiled(
                  title: LocaleKeys.newPassword,
                  controller: cubit.passwordController,
                  isPassword: true,
                  textInputType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(Icons.lock_outline),
                  hint: LocaleKeys.pleaseEnterYourPassword,
                  validator: (value) => Validators.validatePassword(
                    value,
                    fieldTitle: LocaleKeys.newPassword,
                  ),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: AppSize.sH14),
                CustomTextFiled(
                  title: LocaleKeys.confirmPassword,
                  controller: cubit.confirmPasswordController,
                  isPassword: true,
                  textInputType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(Icons.lock_outline),
                  hint: LocaleKeys.confirmPassword,
                  validator: (value) => Validators.validatePasswordConfirm(
                    value,
                    cubit.passwordController.text,
                    fieldTitle: LocaleKeys.confirmPassword,
                  ),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => cubit.submit(),
                ),
              ],
              buttonTitle: LocaleKeys.resetPassword,
              onSubmit: cubit.submit,
              isLoading: state.isLoading,
              footer: const SizedBox.shrink(),
            ),
          ),
        );
      },
    ),
  );
}
