part of '../imports/stadiums_imports.dart';

class StadiumHomePayload {
  final List<SportCategory> sports;
  final List<Stadium> stadiums;

  const StadiumHomePayload({required this.sports, required this.stadiums});
}

class SportCategory {
  final String name;
  final String imageUrl;

  const SportCategory({required this.name, required this.imageUrl});
}

class StadiumService {
  final String name;
  final IconData icon;

  const StadiumService({required this.name, required this.icon});
}

class Stadium {
  final int id;
  final String name;
  final String location;
  final String sport;
  final int price;
  final double rating;
  final String imageUrl;
  final List<String> detailImageUrls;
  final String description;
  final String openHours;
  final List<StadiumService> services;

  const Stadium({
    required this.id,
    required this.name,
    required this.location,
    required this.sport,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.detailImageUrls,
    required this.description,
    required this.openHours,
    required this.services,
  });

  String get detailImageUrl => detailImageUrls.first;
}

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
}
