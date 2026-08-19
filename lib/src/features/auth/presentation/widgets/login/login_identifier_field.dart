part of '../../imports/view_imports.dart';

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
