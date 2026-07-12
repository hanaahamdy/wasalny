part of '../../imports/view_imports.dart';

Future logOut() async {
  return showModalBottomSheet(
    context: Go.context,
    isScrollControlled: true,
    backgroundColor: AppColors.transparent,
    builder: (context) => BlocProvider(
      create: (context) => injector<LogOutCubit>(),
      child: const _LogOutBody(),
    ),
  );
}

class _LogOutBody extends StatelessWidget {
  const _LogOutBody();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          left: AppPadding.pW24,
          right: AppPadding.pW24,
          top: AppPadding.pH8,
          bottom:
              AppSize.sH40 +
              (ScreenUtil().bottomBarHeight == 0
                  ? AppSize.sH0
                  : ScreenUtil().bottomBarHeight),
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppCircular.r20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppSize.sW60,
              height: AppSize.sH4,
              decoration: BoxDecoration(
                color: AppColors.changePhoneSheetHandle,
                borderRadius: BorderRadius.circular(AppCircular.r40),
              ),
            ),
            AppSize.sH24.szH,
            Icon(
              Icons.logout_rounded,
              color: AppColors.logoutDialogDanger,
              size: AppSize.sH48,
            ),
            AppSize.sH20.szH,
            Text(
              LocaleKeys.logout,
              textAlign: TextAlign.center,
              style: const TextStyle().setMainTextColor.s18.medium.setHeight(
                24 / 18,
              ),
            ),
            AppSize.sH16.szH,
            Text(
              LocaleKeys.logoutConfirmationMessage,
              textAlign: TextAlign.center,
              style: const TextStyle().setHintColor.s16.regular.setHeight(
                24 / 16,
              ),
            ),
            AppSize.sH24.szH,
            Row(
              textDirection: ui.TextDirection.ltr,
              spacing: AppMargin.mW8,
              children: [
                Expanded(
                  child: LoadingButton(
                    height: AppSize.sH56,
                    title: LocaleKeys.logout,
                    color: AppColors.white,
                    textColor: AppColors.logoutDialogDanger,
                    borderRadius: AppCircular.r40,
                    borderSide: const BorderSide(
                      color: AppColors.logoutDialogDangerBorder,
                    ),
                    onTap: () async => context.read<LogOutCubit>().logout(),
                  ),
                ),
                Expanded(
                  child: LoadingButton(
                    height: AppSize.sH56,
                    title: LocaleKeys.back,
                    color: AppColors.logoutDialogSecondaryButton,
                    textColor: AppColors.logoutDialogSecondaryText,
                    borderRadius: AppCircular.r40,
                    onTap: () async => Go.back(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
