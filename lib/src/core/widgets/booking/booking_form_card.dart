import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/language/locale_keys.g.dart';
import '../../../config/res/config_imports.dart';
import '../../extensions/widgets/sized_box_helper.dart';
import '../../helpers/validators.dart';
import '../fields/drop_downs/app_drop_down/app_dropdown.dart';
import '../fields/text_fields/custom_text_field.dart';
import 'booking_type.dart';

class BookingFormCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<BookingType> bookingTypes;
  final BookingType? selectedBookingType;
  final TextEditingController fromDateTimeController;
  final TextEditingController toDateTimeController;
  final ValueChanged<BookingType?> onBookingTypeChanged;
  final VoidCallback onFromDateTimeTap;
  final VoidCallback onToDateTimeTap;

  const BookingFormCard({
    super.key,
    required this.formKey,
    required this.bookingTypes,
    required this.selectedBookingType,
    required this.fromDateTimeController,
    required this.toDateTimeController,
    required this.onBookingTypeChanged,
    required this.onFromDateTimeTap,
    required this.onToDateTimeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .06),
            blurRadius: 55.r,
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppDropdown<BookingType>(
              label: LocaleKeys.stadiumsBookingType,
              hint: LocaleKeys.createTeamSelectType,
              value: selectedBookingType,
              items: bookingTypes,
              itemAsString: (type) => type.label,
              onChanged: onBookingTypeChanged,
              height: 56.h,
              showSearchBox: false,
              borderRadius: BorderRadius.circular(16.r),
              validator: (value) => Validators.validateDropDown(
                value,
                fieldTitle: LocaleKeys.stadiumsBookingType,
              ),
            ),
            AppSize.sH12.szH,
            CustomTextFiled(
              controller: fromDateTimeController,
              title: LocaleKeys.stadiumsBookingDateTime,
              hint: LocaleKeys.stadiumsBookingFrom,
              isOptional: true,
              readOnly: true,
              onTap: onFromDateTimeTap,
              suffixIcon: const _BookingDateTimeIcon(),
              textInputType: TextInputType.datetime,
              textInputAction: TextInputAction.done,
              borderRadius: BorderRadius.circular(16.r),
              validator: (value) => Validators.validateEmpty(
                value,
                fieldTitle: LocaleKeys.stadiumsBookingDateTime,
              ),
            ),
            AppSize.sH12.szH,
            CustomTextFiled(
              controller: toDateTimeController,
              hint: LocaleKeys.stadiumsBookingTo,
              isOptional: true,
              readOnly: true,
              onTap: onToDateTimeTap,
              suffixIcon: const _BookingDateTimeIcon(),
              textInputType: TextInputType.datetime,
              textInputAction: TextInputAction.done,
              borderRadius: BorderRadius.circular(16.r),
              validator: (value) => Validators.validateEndDateTime(
                value,
                startDateTime: fromDateTimeController.text,
                fieldTitle: LocaleKeys.stadiumsBookingDateTime,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingDateTimeIcon extends StatelessWidget {
  const _BookingDateTimeIcon();

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
    'assets/svg/base_svg/booking_date_time.svg',
    width: 24.r,
    height: 24.r,
  );
}
