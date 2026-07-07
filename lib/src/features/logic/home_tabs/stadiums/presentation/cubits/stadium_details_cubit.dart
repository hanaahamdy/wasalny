part of '../imports/stadiums_imports.dart';

class StadiumDetailsCubit extends Cubit<StadiumCubitState<Stadium>> {
  StadiumDetailsCubit() : super(const StadiumCubitState());

  Future<void> getStadium(int stadiumId) async {
    emit(state.loading());
    try {
      final stadium = await _FakeStadiumApi.getStadium(stadiumId);
      emit(state.success(stadium));
    } catch (error) {
      emit(state.error(error.toString()));
    }
  }
}
