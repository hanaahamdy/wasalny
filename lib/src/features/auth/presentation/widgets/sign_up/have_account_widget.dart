part of '../../imports/view_imports.dart';

class _LoginLink extends StatelessWidget {
  const _LoginLink();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Go.back(),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size(AppSize.sW40, AppSize.sH35),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: RichText(
        textAlign: TextAlign.center,
        textDirection: ui.TextDirection.rtl,
        text: TextSpan(
          style: context.textStyle,
          children: [
            TextSpan(
              text: '${LocaleKeys.signUpAlreadyHaveAccount} ',
              style: context.textStyle.setHintColor.s14.regular,
            ),
            TextSpan(
              text: LocaleKeys.login,
              style: context.textStyle
                  .setColor(AppColors.signUpLoginLinkText)
                  .s16
                  .medium,
            ),
          ],
        ),
      ),
    );
  }
}
