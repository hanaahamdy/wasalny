import 'package:equatable/equatable.dart';

class DistrictEntity extends Equatable {
  final int id;
  final int cityId;
  final String name;

  const DistrictEntity({
    required this.id,
    required this.cityId,
    required this.name,
  });

  factory DistrictEntity.fromJson(Map<String, dynamic> json) => DistrictEntity(
    id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
    cityId: int.tryParse(json['city_id']?.toString() ?? '') ?? 0,
    name: json['name']?.toString() ?? '',
  );

  @override
  List<Object?> get props => [id, cityId, name];
}
