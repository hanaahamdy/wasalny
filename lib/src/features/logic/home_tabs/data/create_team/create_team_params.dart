part of '../../create_team/presentation/imports/view_imports.dart';

class CreateTeamSport {
  final int id;
  final String name;

  const CreateTeamSport({required this.id, required this.name});

  factory CreateTeamSport.fromJson(Map<String, dynamic> json) =>
      CreateTeamSport(
        id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
        name: json['name']?.toString() ?? '',
      );
}

class CreateTeamParams {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController teamNameController = TextEditingController();
  final TextEditingController playersCountController = TextEditingController();
  final ValueNotifier<CreateTeamSport?> selectedSportNotifier =
      ValueNotifier<CreateTeamSport?>(null);
  final ValueNotifier<File?> teamImageNotifier = ValueNotifier<File?>(null);

  bool validate() => formKey.currentState?.validate() ?? false;

  Map<String, dynamic> toJson() => {
    'name': teamNameController.text.trim(),
    'sport_id': selectedSportNotifier.value!.id,
    'expected_players': int.parse(playersCountController.text.trim()),
    'founded_year': DateTime.now().year,
    if (teamImageNotifier.value != null) 'logo': teamImageNotifier.value,
  };

  void dispose() {
    teamNameController.dispose();
    playersCountController.dispose();
    selectedSportNotifier.dispose();
    teamImageNotifier.dispose();
  }
}
