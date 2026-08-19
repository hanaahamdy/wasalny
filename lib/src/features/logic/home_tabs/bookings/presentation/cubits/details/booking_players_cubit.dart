part of '../../bookings_feature.dart';

class BookingPlayersCubit extends AsyncCubit<List<BookingPlayerEntity>> {
  final int bookingId;

  BookingPlayersCubit({required this.bookingId}) : super(const []);

  Future<void> fetchPlayers() async {
    setLoading();
    try {
      final players = await _getBookingPlayers();
      setSuccess(data: players);
    } catch (error) {
      setError(errorMessage: error.toString());
    }
  }

  Future<List<BookingPlayerEntity>> _getBookingPlayers() async {
    final response = await injector<NetworkService>()
        .callApi<List<BookingPlayerEntity>>(
          NetworkRequest(
            method: RequestMethod.get,
            path: ApiConstants.bookingDetails(bookingId),
          ),
          mapper: (json) {
            final response = json is Map
                ? Map<String, dynamic>.from(json)
                : const <String, dynamic>{};
            final data = response['data'];
            final booking = data is Map
                ? Map<String, dynamic>.from(data)
                : const <String, dynamic>{};
            final players = booking['players'];
            if (players is! List) return const [];
            return players
                .whereType<Map>()
                .map(
                  (player) => BookingPlayerEntity.fromJson(
                    Map<String, dynamic>.from(player),
                  ),
                )
                .toList();
          },
        );
    return response.data;
  }
}
