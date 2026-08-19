part of '../../create_match/presentation/imports/create_match_imports.dart';

class CreateMatchSummaryModel {
  final CreateMatchParams params;
  final CreateMatchTeam opponent;
  final CreateMatchStadium stadium;
  final BookingPaymentMethod paymentMethod;
  final DateTime endsAt;

  const CreateMatchSummaryModel({
    required this.params,
    required this.opponent,
    required this.stadium,
    required this.paymentMethod,
    required this.endsAt,
  });

  String get bookingType => params.bookingType.label;
  String get payment => paymentMethod.label;

  String get dateTime => '${_format(params.startsAt)} - ${_format(endsAt)}';

  String get price => stadium.price.toString();

  static String _format(DateTime value) => DateFormat(
    'yyyy/MM/dd - hh:mm a',
    Languages.currentLanguage.locale.languageCode,
  ).format(value);
}
