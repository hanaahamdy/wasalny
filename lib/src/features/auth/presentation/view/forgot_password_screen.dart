part of '../imports/view_imports.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => ForgotPasswordCubit(),
    child: Builder(
      builder: (context) {
        final cubit = context.read<ForgotPasswordCubit>();
        return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
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
              if (state.successMessage?.isNotEmpty == true) {
                MessageUtils.showSnackBar(
                  context: context,
                  baseStatus: BaseStatus.success,
                  message: state.successMessage!,
                );
              }
              Go.to(
                ForgotPasswordOtpScreen(
                  email: cubit.emailController.text.trim(),
                ),
              );
            }
          },
          builder: (context, state) => AuthShell(
            child: AuthFormCard(
              formKey: cubit.formKey,
              title: LocaleKeys.forgotPassword,
              subtitle: LocaleKeys.forgotPasswordSubtitle,
              fields: [
                CustomTextFiled(
                  title: LocaleKeys.email,
                  hint: LocaleKeys.enterTheEmail,
                  controller: cubit.emailController,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(Icons.mail_outline),
                  validator: (value) => Validators.validateEmail(
                    value,
                    fieldTitle: LocaleKeys.email,
                  ),
                  onSubmitted: (_) => cubit.submit(),
                ),
              ],
              buttonTitle: LocaleKeys.sendBtn,
              onSubmit: cubit.submit,
              isLoading: state.isLoading,
              footer: AuthActionLink(
                label: '',
                action: LocaleKeys.login,
                onTap: Go.back,
              ),
            ),
          ),
        );
      },
    ),
  );
}
