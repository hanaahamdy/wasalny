import '../../config/language/locale_keys.g.dart';

class Validators {
  static String? validateEmpty(String? value, {String? fieldTitle}) {
    if (value == null || value.isEmpty) {
      return fieldTitle == null
          ? LocaleKeys.fillField
          : '${LocaleKeys.filedValidation} $fieldTitle';
    } else if (RegExp(r'[<>]').hasMatch(value)) {
      return LocaleKeys.scripInjectionValidate;
    }

    return null;
  }

  static String? validateEmail(String? value, {String? fieldTitle}) {
    if (value?.trim().isEmpty ?? true) {
      return fieldTitle == null
          ? LocaleKeys.fillField
          : '${LocaleKeys.filedValidation} $fieldTitle';
    } else if (RegExp(r'[<>]').hasMatch(value!)) {
      return LocaleKeys.scripInjectionValidate;
    } else if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.["
      r'a-zA-Z]+',
    ).hasMatch(value)) {
      return LocaleKeys.mailValidation;
    }
    return null;
  }

  static String? validateName(String? value, {String? fieldTitle}) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) {
      return fieldTitle == null
          ? LocaleKeys.fillField
          : '${LocaleKeys.filedValidation} $fieldTitle';
    } else if (RegExp(r'[<>]').hasMatch(name)) {
      return LocaleKeys.scripInjectionValidate;
    } else if (name.runes.length < 2) {
      return LocaleKeys.nameMinTwoCharacters;
    }
    return null;
  }

  static String? validatePassword(
    String? value, {
    String? fieldTitle,
    int minLength = 8,
  }) {
    if (value?.trim().isEmpty ?? true) {
      return fieldTitle == null
          ? LocaleKeys.fillField
          : "${LocaleKeys.filedValidation} $fieldTitle";
    } else if (value!.length < minLength) {
      return LocaleKeys.passValidation;
    } else if (RegExp(r'[<>]').hasMatch(value)) {
      return LocaleKeys.scripInjectionValidate;
    }
    return null;
  }

  static String? validatePasswordConfirm(
    String? value,
    String? pass, {
    String? fieldTitle,
  }) {
    if (value?.trim().isEmpty ?? true) {
      return fieldTitle == null
          ? LocaleKeys.fillField
          : "${LocaleKeys.filedValidation} $fieldTitle";
    } else if (RegExp(r'[<>]').hasMatch(value!)) {
      return LocaleKeys.scripInjectionValidate;
    } else if (value != pass) {
      return LocaleKeys.confirmValidation;
    }
    return null;
  }

  static String? validatePhone(String? value, {String? fieldTitle}) {
    if (value?.trim().isEmpty ?? true) {
      return fieldTitle == null
          ? LocaleKeys.fillField
          : '${LocaleKeys.filedValidation} $fieldTitle';
    } else if (RegExp(r'[<>]').hasMatch(value!)) {
      return LocaleKeys.scripInjectionValidate;
    } else if (!RegExp(r'^5\d{8}$').hasMatch(value.trim())) {
      return LocaleKeys.phoneValidation;
    }
    return null;
  }

  static String? validatePositiveInteger(String? value, {String? fieldTitle}) {
    final emptyError = validateEmpty(value, fieldTitle: fieldTitle);
    if (emptyError != null) return emptyError;

    final number = int.tryParse(value!.trim());
    if (number == null || number <= 0) {
      return LocaleKeys.validationInvalidNumber;
    }
    return null;
  }

  static String? noValidate(String value) {
    if (RegExp(r'[<>]').hasMatch(value)) {
      return LocaleKeys.scripInjectionValidate;
    } else {
      return null;
    }
  }

  static String? validateDropDown<T>(T? value, {String? fieldTitle}) {
    if (value == null) {
      return fieldTitle != null
          ? '${LocaleKeys.please} $fieldTitle'
          : LocaleKeys.fillField;
    } else {
      return null;
    }
  }

  static String? validateEndDateTime(
    String? endDateTime, {
    required String? startDateTime,
    String? fieldTitle,
    int maxDurationHours = 12,
  }) {
    final emptyError = validateEmpty(endDateTime, fieldTitle: fieldTitle);
    if (emptyError != null) return emptyError;

    DateTime? parseDateTime(String? value) =>
        DateTime.tryParse(value?.trim().replaceAll(RegExp(r'\s+'), ' ') ?? '');

    final start = parseDateTime(startDateTime);
    final end = parseDateTime(endDateTime);
    if (start != null && (end == null || !end.isAfter(start))) {
      return LocaleKeys.stadiumsInvalidBookingPeriod;
    }
    if (start != null &&
        end != null &&
        end.difference(start) > Duration(hours: maxDurationHours)) {
      return LocaleKeys.stadiumsBookingDurationTooLong;
    }
    return null;
  }
}
