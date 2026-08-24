import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/language/locale_keys.g.dart';
import '../../../config/res/config_imports.dart';
import '../../extensions/base_state.dart';
import '../../helpers/location_helper.dart';
import '../../helpers/validators.dart';
import '../../navigation/navigator.dart';
import '../../widgets/custom_messages.dart';
import '../../widgets/fields/text_fields/custom_text_field.dart';
import '../imports/imports.dart';

class LocationTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(LocationModel) onLocationSelected;
  final LocationModel? initialLocation;
  final String? label;
  final bool isRequired;

  const LocationTextField({
    this.label,
    super.key,
    this.controller,
    required this.onLocationSelected,
    this.initialLocation,
    this.isRequired = false,
  });

  Future<void> handleTap(BuildContext context) async {
    try {
      final hasPermission = await LocationHelper.checkLocationPermission();
      if (!hasPermission) {
        final granted = await LocationHelper.askForLocationPermission();
        if (!granted) {
          MessageUtils.showSnackBar(
            baseStatus: BaseStatus.error,
            message: LocaleKeys.pleaseEnableLocationServicesInSettings,
          );
          return;
        }
      }
    } on LocationException catch (exception) {
      MessageUtils.showSnackBar(
        baseStatus: BaseStatus.error,
        message: exception.message,
      );
      return;
    }

    final LocationModel? selectedLocation = await Go.to(
      LocationScreen(initialLocation: initialLocation),
    );

    if (selectedLocation != null) {
      controller?.text = selectedLocation.descriptiveLocation.toString();
      onLocationSelected(selectedLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFiled(
      suffixIcon: Icon(
        Icons.location_on_outlined,
        color: AppColors.grey2,
        size: 20.h,
      ),
      controller: controller,
      onTap: () => handleTap(context),
      validator: (val) {
        if (initialLocation == null) {
          return Validators.validateEmpty(val);
        }
        return null;
      },
      hint: LocaleKeys.selectTheLocation,
      readOnly: true,
      title: label ?? LocaleKeys.location,
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
    );
  }
}
