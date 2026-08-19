part of '../../sports/presentation/sports_feature.dart';

class SportCategory {
  final int id;
  final String name;
  final String imageUrl;

  const SportCategory({
    this.id = 0,
    required this.name,
    required this.imageUrl,
  });

  factory SportCategory.fromJson(Map<String, dynamic> json) => SportCategory(
    id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
    name: json['name']?.toString() ?? '',
    imageUrl: (json['image'] ?? json['icon'])?.toString() ?? '',
  );
}
