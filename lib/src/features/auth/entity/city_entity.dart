import 'package:equatable/equatable.dart';

class CityEntity extends Equatable {
  final int id;
  final String name;

  const CityEntity({required this.id, required this.name});

  factory CityEntity.fromJson(Map<String, dynamic> json) => CityEntity(
    id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
    name: json['name']?.toString() ?? '',
  );

  @override
  List<Object?> get props => [id, name];
}
