part of '../../../create_match/presentation/imports/create_match_imports.dart';

class CreateMatchStadiumsPage {
  final List<CreateMatchStadium> stadiums;
  final int currentPage;
  final int lastPage;

  const CreateMatchStadiumsPage({
    required this.stadiums,
    required this.currentPage,
    required this.lastPage,
  });
}
