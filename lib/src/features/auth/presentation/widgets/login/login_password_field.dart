part of '../../imports/view_imports.dart';

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
          Validators.validatePassword(value, fieldTitle: LocaleKeys.password),
    );
  }
}
