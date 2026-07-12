part of '../imports/view_imports.dart';

class CreateTeamCubit extends AsyncCubit<BaseModel?> {
  CreateTeamCubit() : super(null);

  final CreateTeamParams params = CreateTeamParams();

  void selectSport(String? sport) {
    params.selectedSportNotifier.value = sport;
  }

  Future<void> pickTeamImage() async {
    final image = await ImageHelper.getImageFromCameraOrDevice();
    if (image == null) return;
    params.teamImageNotifier.value = image;
  }

  void removeTeamImage() {
    params.teamImageNotifier.value = null;
  }

  Future<void> submit() async {
    if (!params.validate()) return;

    setLoading();
    await successDialog(
      context: Go.context,
      title: LocaleKeys.teamJoinAcceptedSuccessfully,
    );
    setSuccess(data: null);
    Go.back();
  }

  @override
  Future<void> close() {
    params.dispose();
    return super.close();
  }
}
