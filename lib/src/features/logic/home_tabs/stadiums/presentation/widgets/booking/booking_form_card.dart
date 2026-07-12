part of '../../imports/stadiums_imports.dart';

class _BookingFormCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<String> bookingTypes;
  final String? selectedBookingType;
  final TextEditingController dateTimeController;
  final ValueChanged<String?> onBookingTypeChanged;
  final VoidCallback onDateTimeTap;

  const _BookingFormCard({
    required this.formKey,
    required this.bookingTypes,
    required this.selectedBookingType,
    required this.dateTimeController,
    required this.onBookingTypeChanged,
    required this.onDateTimeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
            AppDropdown<String>(
              label: LocaleKeys.stadiumsBookingType,
              hint: LocaleKeys.createTeamSelectType,
              value: selectedBookingType,
              items: bookingTypes,
              itemAsString: (type) => type,
              onChanged: onBookingTypeChanged,
              height: 56.h,
              showSearchBox: false,
              borderRadius: BorderRadius.circular(16.r),
              validator: (value) => Validators.validateDropDown(
                value,
                fieldTitle: LocaleKeys.stadiumsBookingType,
              ),
            ),
            AppSize.sH20.szH,
            CustomTextFiled(
              controller: dateTimeController,
              title: LocaleKeys.stadiumsBookingDateTime,
              hint: LocaleKeys.stadiumsSelectBookingDateTime,
              isOptional: true,
              readOnly: true,
              onTap: onDateTimeTap,
              suffixIcon: Icon(
                Icons.calendar_month_outlined,
                color: AppColors.avatarCameraIcon,
                size: 22.r,
              ),
              textInputType: TextInputType.datetime,
              textInputAction: TextInputAction.done,
              borderRadius: BorderRadius.circular(16.r),
              validator: (value) => Validators.validateEmpty(
                value,
                fieldTitle: LocaleKeys.stadiumsBookingDateTime,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
