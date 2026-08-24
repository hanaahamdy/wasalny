part of '../imports/view_imports.dart';

class IntroLogo extends StatelessWidget {
  final IntroSlideModel slide;

  const IntroLogo({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 62.w,
          height: 62.w,
          padding: EdgeInsets.all(AppPadding.pW14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppCircular.r15),
          ),
          child: AppAssets.svg.appSvg.appLogoPng.image(fit: BoxFit.contain),
        ),
        SizedBox(height: AppSize.sH14),
        Text(
          slide.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.white,
            fontSize: FontSizeManager.s20,
            fontWeight: FontWeightManager.bold,
          ),
        ),
        SizedBox(height: AppSize.sH2),
        Text(
          slide.subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.white,
            fontSize: FontSizeManager.s11,
            fontWeight: FontWeightManager.regular,
          ),
        ),
      ],
    );
  }
}
