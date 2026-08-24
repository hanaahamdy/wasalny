part of '../imports/view_imports.dart';

class AuthActionLink extends StatelessWidget {
  final String label;
  final String action;
  final VoidCallback onTap;

  const AuthActionLink({
    super.key,
    required this.label,
    required this.action,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: AppSize.sW4,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.hintText,
            fontSize: FontSizeManager.s12,
            fontWeight: FontWeightManager.regular,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPadding.pW4,
              vertical: AppPadding.pH4,
            ),
            child: Text(
              action,
              style: TextStyle(
                color: AppColors.authLinkText,
                fontSize: FontSizeManager.s12,
                fontWeight: FontWeightManager.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
