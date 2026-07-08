part of '../imports/stadiums_imports.dart';

class _FakeStadiumApi {
  static List<SportCategory> get _sports => [
    SportCategory(
      name: LocaleKeys.stadiumsFootball,
      imageUrl:
          'https://images.unsplash.com/photo-1517927033932-b3d18e61fb3a?auto=format&fit=crop&w=300&q=80',
    ),
    SportCategory(
      name: LocaleKeys.stadiumsBasketball,
      imageUrl:
          'https://images.unsplash.com/photo-1546519638-68e109498ffc?auto=format&fit=crop&w=300&q=80',
    ),
    SportCategory(
      name: LocaleKeys.stadiumsTennis,
      imageUrl:
          'https://images.unsplash.com/photo-1622279457486-62dcc4a431d6?auto=format&fit=crop&w=300&q=80',
    ),
    SportCategory(
      name: LocaleKeys.stadiumsPadel,
      imageUrl:
          'https://images.unsplash.com/photo-1626224583764-f87db24ac4ea?auto=format&fit=crop&w=300&q=80',
    ),
  ];

  static List<StadiumService> get _services => [
    StadiumService(name: LocaleKeys.stadiumsWc, icon: Icons.male_rounded),
    StadiumService(
      name: LocaleKeys.stadiumsLockerRooms,
      icon: Icons.checkroom_rounded,
    ),
    StadiumService(
      name: LocaleKeys.stadiumsShower,
      icon: Icons.water_drop_outlined,
    ),
    StadiumService(
      name: LocaleKeys.stadiumsParking,
      icon: Icons.local_parking_rounded,
    ),
    StadiumService(
      name: LocaleKeys.stadiumsCafeteria,
      icon: Icons.storefront_rounded,
    ),
    StadiumService(
      name: LocaleKeys.stadiumsFirstAid,
      icon: Icons.health_and_safety,
    ),
  ];

  static List<Stadium> get _stadiums => [
    Stadium(
      id: 1,
      name: LocaleKeys.stadiumsNakheelName,
      location: LocaleKeys.stadiumsNakheelLocation,
      sport: LocaleKeys.stadiumsFootball,
      price: 200,
      rating: 4.8,
      imageUrl:
          'https://images.unsplash.com/photo-1508098682722-e99c43a406b2?auto=format&fit=crop&w=900&q=80',
      detailImageUrl:
          'https://images.unsplash.com/photo-1540379708242-14a809bef941?auto=format&fit=crop&w=1200&q=80',
      description: LocaleKeys.stadiumsNakheelDescription,
      openHours: LocaleKeys.stadiumsNakheelHours,
      services: _services,
    ),
    Stadium(
      id: 2,
      name: LocaleKeys.stadiumsFaisaliahName,
      location: LocaleKeys.stadiumsFaisaliahLocation,
      sport: LocaleKeys.stadiumsFootball,
      price: 200,
      rating: 4.8,
      imageUrl:
          'https://images.unsplash.com/photo-1522778119026-d647f0596c20?auto=format&fit=crop&w=900&q=80',
      detailImageUrl:
          'https://images.unsplash.com/photo-1522778034537-20a2486be803?auto=format&fit=crop&w=1200&q=80',
      description: LocaleKeys.stadiumsFaisaliahDescription,
      openHours: LocaleKeys.stadiumsFaisaliahHours,
      services: _services,
    ),
    Stadium(
      id: 3,
      name: LocaleKeys.stadiumsOasisName,
      location: LocaleKeys.stadiumsOasisLocation,
      sport: LocaleKeys.stadiumsFootball,
      price: 180,
      rating: 4.7,
      imageUrl:
          'https://images.unsplash.com/photo-1577223625816-7546f13df25d?auto=format&fit=crop&w=900&q=80',
      detailImageUrl:
          'https://images.unsplash.com/photo-1556056504-5c7696c4c28d?auto=format&fit=crop&w=1200&q=80',
      description: LocaleKeys.stadiumsOasisDescription,
      openHours: LocaleKeys.stadiumsOasisHours,
      services: _services,
    ),
  ];

  static Future<StadiumHomePayload> getHomePayload() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return StadiumHomePayload(sports: _sports, stadiums: _stadiums);
  }

  static Future<List<Stadium>> searchStadiums([String? query]) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    final normalized = query?.trim();
    if (normalized == null || normalized.isEmpty) return _stadiums;
    return _stadiums
        .where(
          (stadium) =>
              stadium.name.contains(normalized) ||
              stadium.location.contains(normalized) ||
              stadium.sport.contains(normalized),
        )
        .toList();
  }

  static Future<Stadium> getStadium(int id) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return _stadiums.firstWhere((stadium) => stadium.id == id);
  }

  static Future<BookingSummary> createBooking(int stadiumId) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    final stadium = _stadiums.firstWhere((stadium) => stadium.id == stadiumId);
    return BookingSummary(
      type: LocaleKeys.stadiumsIndividualBooking,
      dateTime: LocaleKeys.stadiumsBookingFakeDatetime,
      price: LocaleKeys.stadiumsRiyalAmount(amount: '${stadium.price - 50}'),
      payment: LocaleKeys.stadiumsOnlinePayment,
    );
  }
}
