part of '../imports/view_imports.dart';

class IntroStartButton extends StatelessWidget {
  final VoidCallback onTap;

  const IntroStartButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      width: 88.w,
      height: 34.h,
      title: LocaleKeys.introStartnow,
      onTap: onTap,
      color: Colors.transparent,
      borderColor: AppColors.introButtonBorder,
      borderRadius: BorderRadius.circular(AppCircular.r8),
      textColor: AppColors.white,
      fontSize: FontSizeManager.s11,
      fontWeight: FontWeightManager.regular,
      elevation: 0,
    );
  }
}
