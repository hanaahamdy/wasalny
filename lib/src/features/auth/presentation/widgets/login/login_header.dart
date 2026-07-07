part of '../../imports/view_imports.dart';

class _LoginHeader extends StatelessWidget {
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
              AppSize.sH10.szH,
              Text(
                LocaleKeys.loginSubtitle,
                textAlign: TextAlign.start,
                style: const TextStyle().setHintColor.s12.regular,
              ),
            ],
          ),
        ),
        AppSize.sW12.szW,
        Container(
          width: AppSize.sW40,
          height: AppSize.sH40,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppCircular.r8),
          ),
          child: Icon(
            Icons.translate,
            color: AppColors.primary,
            size: AppSize.sH22,
          ),
        ),
      ],
    );
  }
}

class _LoginLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppAssets.svg.appSvg.appLogoPng.image(
      width: 118,
      height: 118,
      fit: BoxFit.contain,
    );
  }
}
