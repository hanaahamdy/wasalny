import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import '../../../../config/res/config_imports.dart';
import '../../../extensions/text_style_extensions.dart';
import '../../../extensions/widgets/margin_extention.dart';
import '../../../helpers/validators.dart';
import '../../custom_widget_validator.dart';

class CustomPinTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool hasError;

  const CustomPinTextField({
    required this.controller,
    required this.focusNode,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: 62,
      height: 62,
      textStyle: const TextStyle().setMainTextColor.s18.medium,
      decoration: BoxDecoration(
        color: AppColors.fieldFillColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        controller: controller,
        focusNode: focusNode,
        length: ConstantManager.pinCodeFieldsCount,
        autofocus: false,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        defaultPinTheme: defaultTheme,
        focusedPinTheme: defaultTheme.copyDecorationWith(
          border: Border.all(color: AppColors.primary),
        ),
        submittedPinTheme: defaultTheme,
        errorPinTheme: defaultTheme.copyDecorationWith(
          border: Border.all(color: AppColors.error),
        ),
        forceErrorState: hasError,
      ),
    );
  }
}
