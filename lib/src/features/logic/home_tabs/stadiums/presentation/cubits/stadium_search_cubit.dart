part of '../imports/stadiums_imports.dart';

class StadiumSearchCubit extends Cubit<StadiumCubitState<List<Stadium>>> {
  StadiumSearchCubit() : super(const StadiumCubitState());

  Future<void> search([String? query]) async {
    emit(state.loading());
    try {
      final stadiums = await _FakeStadiumApi.searchStadiums(query);
      emit(state.success(stadiums));
    } catch (error) {
      emit(state.error(error.toString()));
    }
  }

  Future<void> searchBySport(String sport, [String? query]) async {
    emit(state.loading());
    try {
      final stadiums = await _FakeStadiumApi.searchStadiumsBySport(
        sport,
        query,
      );
      emit(state.success(stadiums));
    } catch (error) {
      emit(state.error(error.toString()));
    }
  }
}
