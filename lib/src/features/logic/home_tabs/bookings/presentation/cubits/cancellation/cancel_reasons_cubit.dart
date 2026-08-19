part of '../../bookings_feature.dart';

class CancelReasonsCubit extends AsyncCubit<List<CancelReasonEntity>> {
  CancelReasonsCubit() : super(const []);

  CancelReasonEntity? get selectedReason {
    return state.data.where((reason) => reason.isSelected).firstOrNull;
  }

  Future<void> fetchCancelReasons() async {
    setLoading();
    try {
      final response = await injector<NetworkService>()
          .callApi<List<CancelReasonEntity>>(
            NetworkRequest(
              method: RequestMethod.get,
              path: ApiConstants.bookingCancelReasons,
            ),
            mapper: (json) {
              final response = json is Map
                  ? Map<String, dynamic>.from(json)
                  : const <String, dynamic>{};
              final data = response['data'];
              final paginatedData = data is Map
                  ? Map<String, dynamic>.from(data)
                  : const <String, dynamic>{};
              final reasons = data is List
                  ? data
                  : paginatedData['data'] is List
                  ? paginatedData['data'] as List
                  : const [];
              return reasons
                  .whereType<Map>()
                  .map(
                    (reason) => CancelReasonEntity.fromJson(
                      Map<String, dynamic>.from(reason),
                    ),
                  )
                  .where((reason) => reason.title.isNotEmpty)
                  .toList();
            },
          );
      setSuccess(data: _selectFirstReason(response.data));
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
