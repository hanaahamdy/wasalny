part of '../imports/stadiums_imports.dart';

class StadiumsHomeCubit extends Cubit<StadiumCubitState<StadiumHomePayload>> {
  StadiumsHomeCubit() : super(const StadiumCubitState());

  Future<void> loadHomePayload() async {
    emit(state.loading());
    try {
      final payload = await _FakeStadiumApi.getHomePayload();
      emit(state.success(payload));
    } catch (error) {
      emit(state.error(error.toString()));
    }
  }
}
