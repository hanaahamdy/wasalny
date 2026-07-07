import 'package:flutter/material.dart';
import '../../../config/res/config_imports.dart';
import '../../extensions/context_extension.dart';
import '../../extensions/text_style_extensions.dart';
import '../../extensions/widgets/widget_extension.dart';
import '../../navigation/navigator.dart';

enum SelectArrowStyleEnum { showMore, arrowBack, arrowRight }

class ArrowWidget extends StatelessWidget {
  final double? width, height;
  final void Function()? onTap;
  final MainAxisAlignment? mainAxisAlignment;

  const ArrowWidget({
    super.key,
    this.height,
    this.width,
    this.onTap,
    this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    final arrowSize = height ?? width ?? AppSize.sH35;

    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      children: [
        Container(
          width: width ?? arrowSize,
          height: height ?? arrowSize,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            context.isRight ? Icons.arrow_forward : Icons.arrow_back,
            color: AppColors.white,
            size: arrowSize * 0.58,
          ),
        ).onClick(onTap: onTap ?? () => Go.back()),
      ],
    );
  }
}

class TitleWithArrowWidget extends StatelessWidget {
  final SelectArrowStyleEnum selectArrowStyleEnum;
  final void Function()? onTap;
  final String tiltle;
  final TextStyle? style;
  final MainAxisAlignment mainAxisAlignment;
  final double? width, height, spacing;

  const TitleWithArrowWidget({
    super.key,
    required this.tiltle,
    this.selectArrowStyleEnum = SelectArrowStyleEnum.arrowBack,
    this.style,
    this.height,
    this.spacing,
    this.width,
    this.onTap,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: spacing ?? AppMargin.mH6,
      children: [
        Text(
          tiltle,
          style: style ?? const TextStyle().setPrimaryColor.s12.regular,
        ),
        ArrowWidget(width: width, height: height),
      ],
    ).onClick(onTap: onTap);
  }
}
