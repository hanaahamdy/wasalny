import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../config/language/languages.dart';
import '../../../config/res/config_imports.dart';
import '../../navigation/navigator.dart';

Future<DateTime?> showCustomDatePicker({
  TextEditingController? controller,
  String? dateFormat,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  final DateTime now = DateTime.now();
  final DateTime? pickedDate = await showDatePicker(
    locale: Languages.currentLanguage.locale,
    context: Go.context,
    initialDate: initialDate ?? now,
    firstDate: firstDate ?? now,
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    lastDate: lastDate ?? now.add(const Duration(days: 365 * 4)),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: AppColors.white,
            onSurface: AppColors.primary,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: AppColors.primary),
          ),
        ),
        child: child!,
      );
    },
  );
  if (pickedDate != null) {
    final String formattedDate = DateFormat(
      dateFormat ?? 'EEE, M/d/y',
      Languages.currentLanguage.locale.languageCode,
    ).format(pickedDate);
    controller?.text = formattedDate;
  }
  return pickedDate;
}

Future<DateTime?> showCustomDateTimePicker({
  DateTime? initialDateTime,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  final context = Go.context;
  final selectedDate = await showCustomDatePicker(
    initialDate: initialDateTime,
    firstDate: firstDate,
    lastDate: lastDate,
  );
  if (selectedDate == null || !context.mounted) return null;

  final selectedTime = await showTimePicker(
    context: context,
    initialTime: initialDateTime == null
        ? TimeOfDay.now()
        : TimeOfDay.fromDateTime(initialDateTime),
  );
  if (selectedTime == null) return null;

  return DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    selectedTime.hour,
    selectedTime.minute,
  );
}
