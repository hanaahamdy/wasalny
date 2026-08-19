part of '../../bookings/presentation/bookings_feature.dart';

enum BookingStatus {
  fresh,
  scheduled,
  active,
  finished;

  String get apiValue => switch (this) {
    BookingStatus.fresh => 'new',
    BookingStatus.scheduled => 'scheduled',
    BookingStatus.active => 'current',
    BookingStatus.finished => 'finished',
  };

  String get label {
    switch (this) {
      case BookingStatus.fresh:
        return LocaleKeys.bookingsStatusNew;
      case BookingStatus.scheduled:
        return LocaleKeys.bookingsStatusScheduled;
      case BookingStatus.active:
        return LocaleKeys.bookingsStatusActive;
      case BookingStatus.finished:
        return LocaleKeys.bookingsStatusFinished;
    }
  }

  Color get color {
    switch (this) {
      case BookingStatus.fresh:
      case BookingStatus.scheduled:
        return AppColors.bookingSuccessGreen;
      case BookingStatus.active:
        return AppColors.primary;
      case BookingStatus.finished:
        return AppColors.bookingDangerRed;
    }
  }
}

class BookingEntity extends Equatable {
  final int id;
  final int? matchId;
  final String code;
  final String title;
  final String type;
  final String location;
  final String date;
  final String time;
  final String duration;
  final int hourPrice;
  final int additionalCost;
  final int total;
  final String currency;
  final String paymentMethodValue;
  final String paymentMethod;
  final String paymentStatus;
  final bool isPaid;
  final bool canPay;
  final bool canApprove;
  final bool canCancel;
  final bool canRate;
  final int playersCount;
  final BookingStatus status;
  final String imageUrl;
  final List<String> services;
  final List<BookingPlayerEntity> players;
  final String bookedAt;
  final String? homeTeam;
  final String? awayTeam;

  const BookingEntity({
    required this.id,
    this.matchId,
    required this.code,
    required this.title,
    required this.type,
    required this.location,
    required this.date,
    required this.time,
    required this.duration,
    required this.hourPrice,
    this.additionalCost = 0,
    required this.total,
    this.currency = 'SAR',
    this.paymentMethodValue = '',
    required this.paymentMethod,
    this.paymentStatus = '',
    required this.isPaid,
    this.canPay = false,
    this.canApprove = false,
    this.canCancel = false,
    this.canRate = false,
    this.playersCount = 0,
    required this.status,
    required this.imageUrl,
    required this.services,
    this.players = const [],
    required this.bookedAt,
    this.homeTeam,
    this.awayTeam,
  });

  bool get isMatch => homeTeam != null && awayTeam != null;

  factory BookingEntity.fromJson(
    Map<String, dynamic> json, {
    required BookingStatus tab,
  }) {
    Map<String, dynamic> mapOf(dynamic value) =>
        value is Map ? Map<String, dynamic>.from(value) : <String, dynamic>{};

    final stadium = mapOf(json['stadium']);
    final type = mapOf(json['type']);
    final teams = mapOf(json['teams']);
    final paymentMethod = mapOf(json['payment_method']);
    final paymentStatus = mapOf(json['payment_status']);
    final playersSummary = mapOf(json['players_summary']);
    final pricing = mapOf(json['pricing']);
    final players = json['players'] is List
        ? (json['players'] as List)
              .whereType<Map>()
              .map(
                (player) => BookingPlayerEntity.fromJson(
                  Map<String, dynamic>.from(player),
                ),
              )
              .toList()
        : const <BookingPlayerEntity>[];
    final durationValue =
        double.tryParse(json['duration_hours']?.toString() ?? '') ?? 0;
    final totalValue =
        double.tryParse(
          (pricing['final_price'] ?? json['price'])?.toString() ?? '',
        ) ??
        0;
    final basePrice =
        double.tryParse(pricing['base_price']?.toString() ?? '') ?? totalValue;
    final additionalCost =
        double.tryParse(pricing['vat_amount']?.toString() ?? '') ?? 0;
    final city = stadium['city']?.toString() ?? '';
    final district = stadium['district']?.toString() ?? '';
    final location = [
      city,
      district,
    ].where((part) => part.isNotEmpty).join('، ');

    return BookingEntity(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      matchId:
          int.tryParse(json['match_id']?.toString() ?? '') ??
          int.tryParse(mapOf(json['match'])['id']?.toString() ?? ''),
      code: json['order_no']?.toString() ?? '',
      title: stadium['name']?.toString() ?? '',
      type: type['label']?.toString() ?? '',
      location: location,
      date: json['date']?.toString() ?? '',
      time: json['start_time']?.toString() ?? '',
      duration: _formatDuration(durationValue),
      hourPrice: durationValue > 0 ? (basePrice / durationValue).round() : 0,
      additionalCost: additionalCost.round(),
      total: totalValue.round(),
      currency: json['currency']?.toString() ?? 'SAR',
      paymentMethodValue: paymentMethod['value']?.toString() ?? '',
      paymentMethod: paymentMethod['label']?.toString() ?? '',
      paymentStatus: paymentStatus['label']?.toString() ?? '',
      isPaid: paymentStatus['value'] == 'paid',
      canPay: json['can_pay'] == true,
      canApprove: json['can_approve'] == true,
      canCancel: json['can_cancel'] == true,
      canRate: json['can_rate'] == true,
      playersCount:
          int.tryParse(playersSummary['total']?.toString() ?? '') ?? 0,
      status: tab,
      imageUrl: stadium['image']?.toString() ?? '',
      services: const [],
      players: players,
      bookedAt: json['created_at']?.toString() ?? '',
      homeTeam: teams['home']?.toString(),
      awayTeam: teams['away']?.toString(),
    );
  }

  static String _formatDuration(double value) {
    final hours = value == value.roundToDouble()
        ? value.toInt().toString()
        : value.toString();
    return '$hours h';
  }

  @override
  List<Object?> get props => [
    id,
    matchId,
    code,
    title,
    type,
    location,
    date,
    time,
    duration,
    hourPrice,
    additionalCost,
    total,
    currency,
    paymentMethodValue,
    paymentMethod,
    paymentStatus,
    isPaid,
    canPay,
    canApprove,
    canCancel,
    canRate,
    playersCount,
    status,
    imageUrl,
    services,
    players,
    bookedAt,
    homeTeam,
    awayTeam,
  ];
}
