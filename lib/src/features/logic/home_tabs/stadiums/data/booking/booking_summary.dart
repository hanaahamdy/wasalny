part of '../../presentation/imports/stadiums_imports.dart';

class BookingSummary {
  final String type;
  final String dateTime;
  final String price;
  final String payment;

  const BookingSummary({
    required this.type,
    required this.dateTime,
    required this.price,
    required this.payment,
  });

  factory BookingSummary.fromJson(Map<String, dynamic> json) {
    final data = _jsonMap(json['data']);
    final type = _jsonMap(data['type']);
    final paymentMethod = _jsonMap(data['payment_method']);
    final date = data['date']?.toString() ?? '';
    final startTime = data['start_time']?.toString() ?? '';
    final duration = data['duration_hours']?.toString() ?? '';
    final currency = data['currency']?.toString() ?? '';
    return BookingSummary(
      type: type['label']?.toString() ?? '',
      dateTime: '$date - $startTime ($duration h)',
      price: '${data['price'] ?? ''} $currency',
      payment: paymentMethod['label']?.toString() ?? '',
    );
  }

  factory BookingSummary.preview({
    required CreateBookingParams params,
    required Stadium stadium,
    required BookingPaymentMethod paymentMethod,
  }) {
    final date = DateFormat('yyyy-MM-dd', 'en').format(params.startsAt);
    final start = DateFormat('HH:mm', 'en').format(params.startsAt);
    final duration = params.endsAt.difference(params.startsAt).inMinutes / 60;
    final price = stadium.price * duration;
    return BookingSummary(
      type: params.bookingType.label,
      dateTime: '$date - $start ($duration h)',
      price: price.toStringAsFixed(price == price.roundToDouble() ? 0 : 2),
      payment: paymentMethod.label,
    );
  }
}
