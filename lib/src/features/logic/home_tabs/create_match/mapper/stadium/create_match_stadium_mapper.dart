part of '../../presentation/imports/create_match_imports.dart';

abstract final class CreateMatchStadiumMapper {
  static CreateMatchStadium fromJson(Map<String, dynamic> json) {
    final location = json['location'] is Map
        ? Map<String, dynamic>.from(json['location'] as Map)
        : const <String, dynamic>{};
    final sport = json['sport'] is Map
        ? Map<String, dynamic>.from(json['sport'] as Map)
        : const <String, dynamic>{};
    return CreateMatchStadium(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      name: json['name']?.toString() ?? '',
      location: (location['address'] ?? location['city'])?.toString() ?? '',
      sport: sport['name']?.toString() ?? '',
      price: int.tryParse(json['pricing']?.toString() ?? '') ?? 0,
      rating: double.tryParse(json['rate']?.toString() ?? '') ?? 0,
    );
  }
}
