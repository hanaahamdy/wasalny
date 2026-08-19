part of '../../bookings_feature.dart';

class BookingsCubit extends AsyncCubit<List<BookingEntity>> {
  BookingsCubit() : super(const []);

  BookingStatus selectedStatus = BookingStatus.fresh;
  int _requestId = 0;

  List<BookingEntity> get filteredBookings => state.data
      .where((booking) => booking.status == selectedStatus)
      .toList(growable: false);

  Future<void> loadBookings([BookingStatus? status]) async {
    final requestedStatus = status ?? selectedStatus;
    final requestId = ++_requestId;
    selectedStatus = requestedStatus;
    setLoading();
    try {
      final bookings = await _getBookings(requestedStatus);
      if (requestId != _requestId) return;
      setSuccess(data: bookings);
    } catch (error) {
      if (requestId != _requestId) return;
      setError(errorMessage: error.toString());
    }
  }

  void selectStatus(BookingStatus status) {
    if (status == selectedStatus) return;
    loadBookings(status);
  }

  Future<List<BookingEntity>> _getBookings(BookingStatus status) async {
    final response = await injector<NetworkService>()
        .callApi<List<BookingEntity>>(
          NetworkRequest(
            method: RequestMethod.get,
            path: ApiConstants.bookings,
            queryParameters: {'tab': status.apiValue},
          ),
          mapper: (json) {
            final response = json is Map
                ? Map<String, dynamic>.from(json)
                : <String, dynamic>{};
            final data = response['data'];
            if (data is! List) return const [];
            return data
                .whereType<Map>()
                .map(
                  (booking) => BookingEntity.fromJson(
                    Map<String, dynamic>.from(booking),
                    tab: status,
                  ),
                )
                .toList();
          },
        );
    return response.data;
  }
}
