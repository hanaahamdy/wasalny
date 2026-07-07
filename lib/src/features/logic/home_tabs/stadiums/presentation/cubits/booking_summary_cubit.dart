part of '../imports/stadiums_imports.dart';

class BookingSummaryCubit extends Cubit<StadiumCubitState<BookingSummary>> {
  BookingSummaryCubit() : super(const StadiumCubitState());

  Future<void> createBooking(int stadiumId) async {
    emit(state.loading());
    try {
      final summary = await _FakeStadiumApi.createBooking(stadiumId);
      emit(state.success(summary));
    } catch (error) {
      emit(state.error(error.toString()));
    }
  }
}
