part of '../imports/view_imports.dart';

class ForgotPasswordOtpScreen extends StatelessWidget {
  final String email;

  const ForgotPasswordOtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => ForgotPasswordOtpCubit(email: email),
    child: Builder(
      builder: (context) {
        final cubit = context.read<ForgotPasswordOtpCubit>();
        return BlocConsumer<ForgotPasswordOtpCubit, ForgotPasswordOtpState>(
          listenWhen: (previous, current) =>
              previous.errorMessage != current.errorMessage ||
              previous.successMessage != current.successMessage ||
              (!previous.isSuccess && current.isSuccess),
          listener: (context, state) {
            if (state.errorMessage != null) {
              MessageUtils.showSnackBar(
                context: context,
                baseStatus: BaseStatus.error,
                message: state.errorMessage!,
              );
            } else if (state.successMessage?.isNotEmpty == true) {
              MessageUtils.showSnackBar(
                context: context,
                baseStatus: BaseStatus.success,
                message: state.successMessage!,
              );
            }
            if (state.isSuccess) {
              Go.to(
                ResetPasswordScreen(
                  email: email,
                  otp: cubit.otpController.text.trim(),
                ),
              );
            }
          },
          builder: (context, state) {
            final minutes = (state.secondsLeft ~/ 60).toString().padLeft(
              2,
              '0',
            );
            final seconds = (state.secondsLeft % 60).toString().padLeft(2, '0');
            return AuthShell(
              child: AuthFormCard(
                formKey: cubit.formKey,
                title: LocaleKeys.activationCode,
                subtitle:
                    '${LocaleKeys.pleaseEnterTheVerificationCodeSentToYourEmail}\n$email',
                fields: [
                  CustomPinTextField(
                    controller: cubit.otpController,
                    focusNode: cubit.focusNode,
                    hasError: state.hasError,
                  ),
                  SizedBox(height: AppSize.sH14),
                  Text(
                    '$minutes:$seconds',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.authLinkText,
                      fontSize: FontSizeManager.s14,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: state.secondsLeft == 0 && !state.isResending
                        ? cubit.resend
                        : null,
                    child: state.isResending
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(LocaleKeys.resendCode),
                  ),
                ],
                buttonTitle: LocaleKeys.continueButton,
                onSubmit: cubit.validateOtp,
                footer: const SizedBox.shrink(),
              ),
            );
          },
        );
      },
    ),
  );
}
