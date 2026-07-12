part of '../presentation/imports/view_imports.dart';

class CreateTeamParams {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController teamNameController = TextEditingController();
  final TextEditingController playersCountController = TextEditingController();
  final ValueNotifier<String?> selectedSportNotifier = ValueNotifier<String?>(
    null,
  );
  final ValueNotifier<File?> teamImageNotifier = ValueNotifier<File?>(null);

  bool validate() => formKey.currentState?.validate() ?? false;

  void dispose() {
    teamNameController.dispose();
    playersCountController.dispose();
    selectedSportNotifier.dispose();
    teamImageNotifier.dispose();
  }
}
