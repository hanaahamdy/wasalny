import '../../../config/language/locale_keys.g.dart';

enum BookingType {
  individual,
  group,
  match;

  String get apiValue => switch (this) {
    BookingType.individual => 'individual',
    BookingType.group => 'group',
    BookingType.match => 'match',
  };

  String get label => switch (this) {
    BookingType.individual => LocaleKeys.stadiumsIndividualBooking,
    BookingType.group => LocaleKeys.stadiumsGroupBooking,
    BookingType.match => LocaleKeys.createMatchBookingType,
  };
}
