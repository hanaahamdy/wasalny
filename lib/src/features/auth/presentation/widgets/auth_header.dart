part of '../imports/view_imports.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.authLinkText,
            fontSize: FontSizeManager.s22,
            fontWeight: FontWeightManager.bold,
          ),
        ),
        SizedBox(height: AppSize.sH8),
        Text(
          subtitle,
          style: TextStyle(
            color: AppColors.hintText,
            fontSize: FontSizeManager.s13,
            fontWeight: FontWeightManager.regular,
          ),
        ),
      ],
    );
  }
}
