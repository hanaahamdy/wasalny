import 'package:flutter/material.dart';

import '../../../config/res/config_imports.dart';
import '../../extensions/context_extension.dart';

class DefaultButton extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  final Color? textColor;
  final Color? color;
  final Gradient? gradient;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;
  final double? width;
  final double? fontSize;
  final double? height;
  final double? elevation;
  final bool? disabled;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final Widget? customChild;
  final bool isFitted;

  const DefaultButton({
    super.key,
    this.title,
    this.onTap,
    this.color,
    this.gradient,
    this.disabled,
    this.textColor,
    this.borderRadius,
    this.margin,
    this.borderColor,
    this.fontFamily,
    this.fontSize,
    this.width,
    this.height,
    this.fontWeight,
    this.elevation,
    this.customChild,
    this.isFitted = true,
  });

  Widget get _defaultChild => Text(
    title ?? 'Click!',
    style: TextStyle(
      color: textColor ?? AppColors.buttonText,
      fontSize: fontSize ?? FontSizeManager.s13,
      fontFamily: fontFamily,
      fontWeight: fontWeight ?? FontWeightManager.medium,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(AppCircular.r8);
    final isDisabled = disabled == true || onTap == null;
    final useGradient = color == null;

    return SizedBox(
      width: width ?? context.width * .9,
      height: height ?? AppSize.sH45,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: useGradient
              ? null
              : isDisabled
              ? AppColors.grey1
              : color,
          gradient: useGradient
              ? isDisabled
                    ? AppColors.disableGradient
                    : (gradient ?? AppColors.scenarioGradient)
              : null,
          borderRadius: effectiveBorderRadius,
        ),
        child: ElevatedButton(
          onPressed: isDisabled ? null : onTap,
          style: ElevatedButton.styleFrom(
            splashFactory: InkRipple.splashFactory,
            surfaceTintColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            disabledForegroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: effectiveBorderRadius,
              side: borderColor != null
                  ? BorderSide(
                      color: borderColor ?? AppColors.buttonColor,
                      width: .5,
                    )
                  : BorderSide.none,
            ),
            elevation: elevation ?? ConstantManager.zeroAsDouble,
          ),
          child: isFitted
              ? FittedBox(child: customChild ?? _defaultChild)
              : customChild ?? _defaultChild,
        ),
      ),
    );
  }
}
