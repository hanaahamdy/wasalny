part of '../imports/view_imports.dart';

class CreateTeamCubit extends AsyncCubit<BaseModel?> {
  CreateTeamCubit() : super(null);

  final CreateTeamParams params = CreateTeamParams();

  void selectSport(CreateTeamSport? sport) {
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
    final dialogContext = Go.context;

    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams<BaseModel?>(
          api: ApiConstants.teams,
          body: params.toJson(),
          httpRequestType: HttpRequestType.post,
          isFromData: true,
          mapper: (json) =>
              BaseModel.fromJson(Map<String, dynamic>.from(json as Map)),
        ),
      ),
    );
    if (!state.isSuccess || !dialogContext.mounted) return;

    await successDialog(
      context: dialogContext,
      title: state.data?.message.isNotEmpty == true
          ? state.data!.message
          : LocaleKeys.dataUpdatedSuccessfully,
    );
    Go.back(true);
  }

  @override
  Future<void> close() {
    params.dispose();
    return super.close();
  }
}
