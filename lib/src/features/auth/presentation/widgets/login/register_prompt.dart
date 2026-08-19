part of '../../imports/view_imports.dart';

class _RegisterPrompt extends StatelessWidget {
  const _RegisterPrompt();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          LocaleKeys.doNotHaveAnAccount.tr(context: context),
          style: const TextStyle().setHintColor.s14.regular,
        ),
        TextButton(
          onPressed: () => Go.to(const SignUpScreen()),
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.pW4),
            minimumSize: Size(AppSize.sW40, AppSize.sH35),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            LocaleKeys.register.tr(context: context),
            style: const TextStyle()
                .setColor(AppColors.authLinkText)
                .s16
                .medium,
          ),
        ),
      ],
    );
  }
}
