part of '../more_screen.dart';

class _LogoutDialog extends StatelessWidget {
  const _LogoutDialog();

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierColor: AppColors.black.withValues(alpha: .5),
      builder: (_) => const _LogoutDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: AppPadding.pW12),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pW16,
          vertical: AppPadding.pH16,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppCircular.r15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.logout,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.main,
                fontSize: FontSizeManager.s16,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            SizedBox(height: AppSize.sH8),
            Text(
              LocaleKeys.logoutConfirmationMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.hintText,
                fontSize: FontSizeManager.s11,
                fontWeight: FontWeightManager.regular,
              ),
            ),
            SizedBox(height: AppSize.sH14),
            DefaultButton(
              width: double.infinity,
              height: AppSize.sH45,
              title: LocaleKeys.logout,
              color: AppColors.error,
              onTap: () async {
                await UserCubit.instance.logout();
                if (context.mounted) Go.offAll(const LoginScreen());
              },
            ),
            SizedBox(height: AppSize.sH8),
            TextButton(
              onPressed: Go.back,
              child: Text(
                LocaleKeys.cancel,
                style: TextStyle(
                  color: AppColors.authTabSelected,
                  fontSize: FontSizeManager.s12,
                  fontWeight: FontWeightManager.medium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
