part of '../bookings_feature.dart';

class _FakeBookingsApi {
  static const _stadiumImage =
      'https://images.unsplash.com/photo-1540379708242-14a809bef941?auto=format&fit=crop&w=1200&q=80';

  static List<BookingEntity> get _bookings => [
    BookingEntity(
      id: 1,
      code: 'BK-2026-001',
      title: LocaleKeys.bookingsStadiumName,
      type: LocaleKeys.bookingsFieldBooking,
      location: LocaleKeys.bookingsLocation,
      date: LocaleKeys.bookingsSampleDate,
      time: LocaleKeys.bookingsSampleTime,
      duration: LocaleKeys.bookingsSampleDuration,
      hourPrice: 200,
      total: 400,
      paymentMethod: LocaleKeys.bookingsVodafoneCash,
      isPaid: true,
      status: BookingStatus.fresh,
      imageUrl: _stadiumImage,
      services: [
        LocaleKeys.stadiumsWc,
        LocaleKeys.stadiumsLockerRooms,
        LocaleKeys.stadiumsParking,
      ],
      bookedAt: LocaleKeys.bookingsBookedAtSample,
    ),
    BookingEntity(
      id: 2,
      code: 'MT-2026-014',
      title: LocaleKeys.bookingsStadiumName,
      type: LocaleKeys.bookingsTeamMatch,
      location: LocaleKeys.bookingsLocation,
      date: LocaleKeys.bookingsSampleDate,
      time: LocaleKeys.bookingsSampleTime,
      duration: LocaleKeys.bookingsSampleDuration,
      hourPrice: 200,
      total: 400,
      paymentMethod: LocaleKeys.bookingsVodafoneCash,
      isPaid: false,
      status: BookingStatus.scheduled,
      imageUrl:
          'https://images.unsplash.com/photo-1508098682722-e99c43a406b2?auto=format&fit=crop&w=1200&q=80',
      services: [
        LocaleKeys.stadiumsWc,
        LocaleKeys.stadiumsShower,
        LocaleKeys.stadiumsCafeteria,
      ],
      bookedAt: LocaleKeys.bookingsBookedAtSample,
      homeTeam: LocaleKeys.bookingsFalcons,
      awayTeam: LocaleKeys.bookingsSouthEagles,
    ),
    BookingEntity(
      id: 3,
      code: 'BK-2026-032',
      title: LocaleKeys.stadiumsOasisName,
      type: LocaleKeys.bookingsFieldBooking,
      location: LocaleKeys.stadiumsOasisLocation,
      date: LocaleKeys.bookingsSampleDate,
      time: LocaleKeys.bookingsSampleTime,
      duration: LocaleKeys.bookingsSampleDuration,
      hourPrice: 180,
      total: 360,
      paymentMethod: LocaleKeys.bookingsVodafoneCash,
      isPaid: true,
      status: BookingStatus.active,
      imageUrl:
          'https://images.unsplash.com/photo-1577223625816-7546f13df25d?auto=format&fit=crop&w=1200&q=80',
      services: [
        LocaleKeys.stadiumsWc,
        LocaleKeys.stadiumsParking,
        LocaleKeys.stadiumsFirstAid,
      ],
      bookedAt: LocaleKeys.bookingsBookedAtSample,
    ),
    BookingEntity(
      id: 4,
      code: 'BK-2026-018',
      title: LocaleKeys.stadiumsFaisaliahName,
      type: LocaleKeys.bookingsFieldBooking,
      location: LocaleKeys.stadiumsFaisaliahLocation,
      date: LocaleKeys.bookingsSampleDate,
      time: LocaleKeys.bookingsSampleTime,
      duration: LocaleKeys.bookingsSampleDuration,
      hourPrice: 200,
      total: 400,
      paymentMethod: LocaleKeys.bookingsVodafoneCash,
      isPaid: true,
      status: BookingStatus.finished,
      imageUrl:
          'https://images.unsplash.com/photo-1522778034537-20a2486be803?auto=format&fit=crop&w=1200&q=80',
      services: [
        LocaleKeys.stadiumsWc,
        LocaleKeys.stadiumsLockerRooms,
        LocaleKeys.stadiumsShower,
      ],
      bookedAt: LocaleKeys.bookingsBookedAtSample,
    ),
  ];

  static Future<List<BookingEntity>> getBookings() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return _bookings;
  }

  static Future<WalletEntity> getWallet() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return WalletEntity(
      balance: 350,
      lastRecharge: 200,
      lastRechargeDate: LocaleKeys.bookingsWalletLastRechargeDate,
      country: LocaleKeys.bookingsCountryEgypt,
    );
  }
}
