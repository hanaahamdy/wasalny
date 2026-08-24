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
          return AuthShell(
            child: AuthFormCard(
              formKey: cubit.formKey,
              title: LocaleKeys.login,
              subtitle: LocaleKeys.loginSubtitle,
              fields: [
                CustomTextFiled(
                  title: LocaleKeys.phoneNumber,
                  hint: LocaleKeys.pleaseEnterYourPhoneNumber,
                  controller: cubit.phoneController,
                  textInputType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone_outlined),
                  validator: (value) => Validators.validatePhone(
                    value,
                    fieldTitle: LocaleKeys.phoneNumber,
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
              secondaryButtonTitle: LocaleKeys.createDeliveryAccount,
              onSecondarySubmit: cubit.createDeliveryAccount,
              footer: AuthActionLink(
                label: LocaleKeys.doNotHaveAnAccount,
                action: LocaleKeys.register,
                onTap: () => Go.off(const RegisterScreen()),
              ),
            ),
          );
        },
      ),
    );
  }
}
