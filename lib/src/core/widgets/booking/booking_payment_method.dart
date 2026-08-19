import '../../../config/language/locale_keys.g.dart';

enum BookingPaymentMethod {
  online,
  cash,
  wallet;

  String get apiValue => switch (this) {
    BookingPaymentMethod.online => 'online',
    BookingPaymentMethod.cash => 'cash',
    BookingPaymentMethod.wallet => 'wallet',
  };

  String get label => switch (this) {
    BookingPaymentMethod.online => LocaleKeys.stadiumsOnlinePayment,
    BookingPaymentMethod.cash => LocaleKeys.stadiumsCashAfterPlay,
    BookingPaymentMethod.wallet => LocaleKeys.stadiumsWalletPayment,
  };
}
