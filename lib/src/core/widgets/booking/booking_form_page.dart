import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/language/locale_keys.g.dart';
import '../../../config/res/config_imports.dart';
import '../custom_appbar.dart';
import 'booking_form_card.dart';
import 'booking_type.dart';
import 'payment_methods_card.dart';

enum BookingFormSource {
  stadiumBooking,
  createMatch;

  List<BookingType> get bookingTypes => switch (this) {
    BookingFormSource.stadiumBooking => const [
      BookingType.individual,
      BookingType.group,
    ],
    BookingFormSource.createMatch => const [BookingType.match],
  };

  String get appBarTitle => switch (this) {
    BookingFormSource.stadiumBooking => LocaleKeys.bookingsBookFieldTitle,
    BookingFormSource.createMatch => LocaleKeys.stadiumsCreateMatch,
  };

  String? get instruction => switch (this) {
    BookingFormSource.stadiumBooking => null,
    BookingFormSource.createMatch => LocaleKeys.createMatchDateTimeInstruction,
  };
}

class BookingFormPage extends StatelessWidget {
  final BookingFormSource source;
  final GlobalKey<FormState> formKey;
  final BookingType? selectedBookingType;
  final TextEditingController fromDateTimeController;
  final TextEditingController toDateTimeController;
  final ValueChanged<BookingType?> onBookingTypeChanged;
  final VoidCallback onFromDateTimeTap;
  final VoidCallback onToDateTimeTap;
  final BookingPaymentMethod? selectedPaymentMethod;
  final ValueChanged<BookingPaymentMethod> onPaymentMethodChanged;
  final Widget bottomAction;

  const BookingFormPage({
    super.key,
    required this.source,
    required this.formKey,
    required this.selectedBookingType,
    required this.fromDateTimeController,
    required this.toDateTimeController,
    required this.onBookingTypeChanged,
    required this.onFromDateTimeTap,
    required this.onToDateTimeTap,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodChanged,
    required this.bottomAction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: source.appBarTitle),
      backgroundColor: AppColors.scaffoldBackground,
      bottomNavigationBar: bottomAction,
      body: ListView(
        padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 32.h),
        children: [
          if (source.instruction case final instruction?) ...[
            Text(
              instruction,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppColors.notificationText,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 28.h),
          ],
          BookingFormCard(
            formKey: formKey,
            bookingTypes: source.bookingTypes,
            selectedBookingType: selectedBookingType,
            fromDateTimeController: fromDateTimeController,
            toDateTimeController: toDateTimeController,
            onBookingTypeChanged: onBookingTypeChanged,
            onFromDateTimeTap: onFromDateTimeTap,
            onToDateTimeTap: onToDateTimeTap,
          ),
          SizedBox(height: 16.h),
          PaymentMethodsCard(
            title: LocaleKeys.stadiumsPaymentMethod,
            methods: const [
              BookingPaymentMethod.online,
              BookingPaymentMethod.wallet,
            ],
            selectedMethod: selectedPaymentMethod,
            onSelected: onPaymentMethodChanged,
          ),
        ],
      ),
    );
  }
}
