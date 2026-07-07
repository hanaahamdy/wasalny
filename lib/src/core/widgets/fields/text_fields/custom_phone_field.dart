import 'package:flutter/material.dart';

import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/config_imports.dart';
import '../../../extensions/text_style_extensions.dart';
import '../../../extensions/widgets/sized_box_helper.dart';
import '../../../helpers/validators.dart';
import 'custom_text_field.dart';

class CustomPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String? title;
  final String? hint;
  final bool showTitle;
  final bool countryCodeAtStart;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign titleTextAlign;
  final TextStyle? titleStyle;
  final String? Function(String?)? validator;

  const CustomPhoneField({
    super.key,
    required this.controller,
    this.textInputAction = TextInputAction.next,
    this.title,
    this.hint,
    this.showTitle = true,
    this.countryCodeAtStart = true,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.titleTextAlign = TextAlign.right,
    this.titleStyle,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final field = Expanded(
      child: CustomTextFiled(
        controller: controller,
        hint: hint ?? LocaleKeys.pleaseEnterYourPhoneNumber,
        title: null,
        textInputType: TextInputType.phone,
        textInputAction: textInputAction,
        borderRadius: BorderRadius.circular(AppCircular.r20),
        validator:
            validator ??
            (value) => Validators.validatePhone(
              value,
              fieldTitle: title ?? LocaleKeys.phoneNumber,
            ),
      ),
    );

    final children = countryCodeAtStart
        ? <Widget>[const CustomCountryCodeBox(), AppSize.sW10.szW, field]
        : <Widget>[field, AppSize.sW10.szW, const CustomCountryCodeBox()];

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        if (showTitle) ...[
          Text(
            title ?? LocaleKeys.phoneNumber,
            textAlign: titleTextAlign,
            style: titleStyle ?? const TextStyle().setMainTextColor.s16.medium,
          ),
          AppSize.sH12.szH,
        ],
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: children),
      ],
    );
  }
}

class CustomCountryCodeBox extends StatelessWidget {
  final String countryCode;
  final String countryLabel;

  const CustomCountryCodeBox({
    super.key,
    this.countryCode = '+966',
    this.countryLabel = 'KSA',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.sW74,
      height: AppSize.sH50,
      decoration: BoxDecoration(
        color: const Color(0xffF7F7F8),
        borderRadius: BorderRadius.circular(AppCircular.r20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(countryCode, style: const TextStyle().setHintColor.s12.regular),
          AppSize.sH4.szH,
          Container(
            width: AppSize.sW27,
            height: AppSize.sH18,
            decoration: BoxDecoration(
              color: const Color(0xff006C35),
              borderRadius: BorderRadius.circular(AppCircular.r2),
            ),
            alignment: Alignment.center,
            child: Text(
              countryLabel,
              style: const TextStyle().setWhiteColor.s8.bold,
            ),
          ),
        ],
      ),
    );
  }
}
