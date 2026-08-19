part of '../../../create_match/presentation/imports/create_match_imports.dart';

class CreateMatchTeam extends Equatable {
  final int id;
  final String name;
  final String playersCount;
  final String imagePath;

  const CreateMatchTeam({
    required this.id,
    required this.name,
    required this.playersCount,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [id, name, playersCount, imagePath];
}
