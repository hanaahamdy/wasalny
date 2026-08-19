part of '../../../create_match/presentation/imports/create_match_imports.dart';

class CreateMatchStadium extends Equatable {
  final int id;
  final String name;
  final String location;
  final String sport;
  final int price;
  final double rating;

  const CreateMatchStadium({
    required this.id,
    required this.name,
    required this.location,
    required this.sport,
    required this.price,
    required this.rating,
  });

  @override
  List<Object?> get props => [id, name, location, sport, price, rating];
}
