part of '../../imports/view_imports.dart';

class _ForgotPasswordButton extends StatelessWidget {
  final _LoginTab selectedTab;

  const _ForgotPasswordButton({required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: TextButton(
        onPressed: () =>
            Go.to(ResetPasswordScreen(byEmail: selectedTab == _LoginTab.email)),
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
