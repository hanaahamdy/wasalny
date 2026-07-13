part of '../bookings_feature.dart';

class CancelReasonsCubit extends AsyncCubit<List<CancelReasonEntity>> {
  CancelReasonsCubit() : super(const []);

  CancelReasonEntity? get selectedReason {
    return state.data.where((reason) => reason.isSelected).firstOrNull;
  }

  Future<void> fetchCancelReasons() async {
    setLoading();
    try {
      final reasons = await _FakeBookingsApi.getCancelReasons();
      setSuccess(data: _selectFirstReason(reasons));
    } catch (error) {
      setError(errorMessage: error.toString());
    }
  }

  void selectReason(CancelReasonEntity reason) {
    updateData(
      state.data
          .map((item) => item.copyWith(isSelected: item.id == reason.id))
          .toList(),
    );
  }

  List<CancelReasonEntity> _selectFirstReason(
    List<CancelReasonEntity> reasons,
  ) {
    if (reasons.isEmpty) return reasons;
    return reasons
        .map(
          (reason) =>
              reason.copyWith(isSelected: reason.id == reasons.first.id),
        )
        .toList();
  }
}
