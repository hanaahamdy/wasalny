part of '../../bookings/presentation/bookings_feature.dart';

class BookingPlayerEntity extends Equatable {
  final int id;
  final int userId;
  final String name;
  final String imageUrl;
  final num shareAmount;
  final String currency;
  final String paymentStatusValue;
  final String paymentStatusLabel;

  const BookingPlayerEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.imageUrl,
    required this.shareAmount,
    required this.currency,
    required this.paymentStatusValue,
    required this.paymentStatusLabel,
  });

  bool get isPaid => paymentStatusValue == 'paid';

  factory BookingPlayerEntity.fromJson(Map<String, dynamic> json) {
    final user = json['user'] is Map
        ? Map<String, dynamic>.from(json['user'] as Map)
        : const <String, dynamic>{};
    final paymentStatus = json['payment_status'] is Map
        ? Map<String, dynamic>.from(json['payment_status'] as Map)
        : const <String, dynamic>{};
    return BookingPlayerEntity(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      userId: int.tryParse(user['id']?.toString() ?? '') ?? 0,
      name: user['name']?.toString() ?? '',
      imageUrl: user['image']?.toString() ?? '',
      shareAmount: num.tryParse(json['share_amount']?.toString() ?? '') ?? 0,
      currency: json['currency']?.toString() ?? 'SAR',
      paymentStatusValue: paymentStatus['value']?.toString() ?? '',
      paymentStatusLabel: paymentStatus['label']?.toString() ?? '',
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    name,
    imageUrl,
    shareAmount,
    currency,
    paymentStatusValue,
    paymentStatusLabel,
  ];
}
