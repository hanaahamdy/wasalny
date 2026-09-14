part of '../imports/view_imports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<LoginCubit>();
          return BlocConsumer<LoginCubit, LoginState>(
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
                final destination = switch (UserCubit.instance.user.role) {
                  UserRole.buyer => const BuyerScreen(),
                  UserRole.packing => const PackingScreen(),
                  UserRole.aliaa => const AliaaScreen(),
                  UserRole.admin || UserRole.delivery => const HomeScreen(),
                };
                Go.offAll(destination);
              }
            },
            builder: (context, state) => AuthShell(
              child: AuthFormCard(
                formKey: cubit.formKey,
                title: LocaleKeys.login,
                subtitle: LocaleKeys.loginSubtitle,
                fields: [
                  CustomTextFiled(
                    title: LocaleKeys.email,
                    hint: LocaleKeys.enterTheEmail,
                    controller: cubit.emailController,
                    textInputType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.mail_outline),
                    validator: (value) => Validators.validateEmail(
                      value,
                      fieldTitle: LocaleKeys.email,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: AppSize.sH14),
                  CustomTextFiled(
                    title: LocaleKeys.password,
                    controller: cubit.passwordController,
                    isPassword: true,
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: AppColors.grey2,
                    ),
                    suffixIcon: const Icon(
                      Icons.visibility_off_outlined,
                      color: AppColors.grey2,
                    ),
                    validator: (value) => Validators.validatePassword(
                      value,
                      fieldTitle: LocaleKeys.password,
                    ),
                    hint: LocaleKeys.pleaseEnterYourPassword,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                  ),
                ],
                buttonTitle: LocaleKeys.login,
                onSubmit: cubit.login,
                isLoading: state.isLoading,
                footer: AuthActionLink(
                  label: LocaleKeys.doNotHaveAnAccount,
                  action: LocaleKeys.register,
                  onTap: () => Go.off(const RegisterScreen()),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
