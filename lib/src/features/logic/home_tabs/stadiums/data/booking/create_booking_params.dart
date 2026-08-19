part of '../../presentation/imports/stadiums_imports.dart';

class CreateBookingParams {
  final int stadiumId;
  final BookingType bookingType;
  final DateTime startsAt;
  final DateTime endsAt;
  final String paymentType;

  const CreateBookingParams({
    required this.stadiumId,
    required this.bookingType,
    required this.startsAt,
    required this.endsAt,
    required this.paymentType,
  });

  Map<String, dynamic> toJson() => {
    'booking_type': bookingType.apiValue,
    'stadium_id': stadiumId,
    'date': _apiDate(startsAt),
    'start_time': _apiTime(startsAt),
    'duration_hours': endsAt.difference(startsAt).inMinutes / 60,
    if (bookingType == BookingType.individual) 'pay_type': paymentType,
  };

  static String _apiDate(DateTime value) =>
      '${value.year.toString().padLeft(4, '0')}-'
      '${value.month.toString().padLeft(2, '0')}-'
      '${value.day.toString().padLeft(2, '0')}';

  static String _apiTime(DateTime value) =>
      '${value.hour.toString().padLeft(2, '0')}:'
      '${value.minute.toString().padLeft(2, '0')}';
}
