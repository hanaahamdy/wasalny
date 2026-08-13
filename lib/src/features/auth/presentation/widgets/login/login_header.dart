part of '../../imports/view_imports.dart';

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.login,
                textAlign: TextAlign.start,
                style: const TextStyle().setMainTextColor.s20.bold,
              ),
              AppSize.sH4.szH,
              Text(
                LocaleKeys.loginSubtitle,
                textAlign: TextAlign.start,
                style: const TextStyle().setHintColor.s12.regular,
              ),
            ],
          ),
        ),
        AppSize.sW12.szW,
        Material(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppCircular.r8),
          child: InkWell(
            onTap: () => LanguagePickerSheet.show(context),
            borderRadius: BorderRadius.circular(AppCircular.r8),
            child: SizedBox(
              width: AppSize.sW40,
              height: AppSize.sH40,
              child: Icon(
                Icons.translate,
                color: AppColors.primary,
                size: AppSize.sH22,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
