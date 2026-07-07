part of '../bookings_feature.dart';

enum BookingStatus {
  fresh,
  scheduled,
  active,
  finished;

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
  final String code;
  final String title;
  final String type;
  final String location;
  final String date;
  final String time;
  final String duration;
  final int hourPrice;
  final int total;
  final String paymentMethod;
  final bool isPaid;
  final BookingStatus status;
  final String imageUrl;
  final List<String> services;
  final String bookedAt;
  final String? homeTeam;
  final String? awayTeam;

  const BookingEntity({
    required this.id,
    required this.code,
    required this.title,
    required this.type,
    required this.location,
    required this.date,
    required this.time,
    required this.duration,
    required this.hourPrice,
    required this.total,
    required this.paymentMethod,
    required this.isPaid,
    required this.status,
    required this.imageUrl,
    required this.services,
    required this.bookedAt,
    this.homeTeam,
    this.awayTeam,
  });

  bool get isMatch => homeTeam != null && awayTeam != null;

  @override
  List<Object?> get props => [
    id,
    code,
    title,
    type,
    location,
    date,
    time,
    duration,
    hourPrice,
    total,
    paymentMethod,
    isPaid,
    status,
    imageUrl,
    services,
    bookedAt,
    homeTeam,
    awayTeam,
  ];
}

class WalletEntity extends Equatable {
  final int balance;
  final int lastRecharge;
  final String lastRechargeDate;
  final String country;

  const WalletEntity({
    required this.balance,
    required this.lastRecharge,
    required this.lastRechargeDate,
    required this.country,
  });

  @override
  List<Object?> get props => [balance, lastRecharge, lastRechargeDate, country];
}
