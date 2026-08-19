part of '../../../create_match/presentation/imports/create_match_imports.dart';

class CreateMatchTeamsPage {
  final List<CreateMatchTeam> teams;
  final int currentPage;
  final int lastPage;

  const CreateMatchTeamsPage({
    required this.teams,
    required this.currentPage,
    required this.lastPage,
  });
}
