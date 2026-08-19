part of '../../imports/view_imports.dart';

class _SignUpHeader extends StatelessWidget {
  const _SignUpHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.signUpHeaderTitle,
          textAlign: TextAlign.right,
          style: const TextStyle().setBlackColor.s16.semiBold,
        ),
        AppSize.sH8.szH,
        Text(
          LocaleKeys.signUpSubtitle,
          textAlign: TextAlign.right,
          style: const TextStyle().setHintColor.s12.regular,
        ),
      ],
    );
  }
}
