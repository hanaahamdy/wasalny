part of '../imports/view_imports.dart';

class AuthBrand extends StatelessWidget {
  const AuthBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 62.w,
          height: 62.h,
          padding: EdgeInsets.all(AppPadding.pW14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppCircular.r15),
          ),
          child: AppAssets.svg.appSvg.appLogoPng.image(fit: BoxFit.contain),
        ),
        // SizedBox(height: AppSize.sH14),
        // Text(
        //   LocaleKeys.introWaslnyTitle,
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //     color: AppColors.white,
        //     fontSize: FontSizeManager.s20,
        //     fontWeight: FontWeightManager.bold,
        //   ),
        // ),
      ],
    );
  }
}
