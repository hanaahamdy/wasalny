part of '../imports/view_imports.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<RegisterCubit>();
          return AuthShell(
            child: AuthFormCard(
              formKey: cubit.formKey,
              title: LocaleKeys.register,
              subtitle: LocaleKeys.createAccount,
              fields: [
                CustomTextFiled(
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  hint: LocaleKeys.enterFullName,
                  title: LocaleKeys.name,
                  controller: cubit.nameController,
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: (value) => Validators.validateName(
                    value,
                    fieldTitle: LocaleKeys.enterFullName,
                  ),
                ),
                SizedBox(height: AppSize.sH14),
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
                  hint: LocaleKeys.enterTheEmail,
                  title: LocaleKeys.email,
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
                  hint: LocaleKeys.pleaseEnterYourPassword,
                  controller: cubit.passwordController,
                  isPassword: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: const Icon(Icons.visibility_off_outlined),
                  validator: (value) => Validators.validatePassword(
                    value,
                    fieldTitle: LocaleKeys.password,
                  ),
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
              ],
              buttonTitle: LocaleKeys.register,
              onSubmit: cubit.register,
              footer: AuthActionLink(
                label: LocaleKeys.signUpAlreadyHaveAccount,
                action: LocaleKeys.login,
                onTap: () => Go.off(const LoginScreen()),
              ),
            ),
          );
        },
      ),
    );
  }
}
