part of '../../bookings_feature.dart';

class BookingDetailsCubit extends AsyncCubit<BookingEntity?> {
  final BookingEntity initialBooking;

  BookingDetailsCubit({required this.initialBooking}) : super(initialBooking);

  Future<void> fetchDetails() async {
    setLoading();
    try {
      final booking = await _getBookingDetails();
      setSuccess(data: booking);
    } catch (error) {
      setError(errorMessage: error.toString());
    }
  }

  Future<BookingEntity> _getBookingDetails() async {
    final response = await injector<NetworkService>().callApi<BookingEntity>(
      NetworkRequest(
        method: RequestMethod.get,
        path: ApiConstants.bookingDetails(initialBooking.id),
      ),
      mapper: (json) {
        final response = json is Map
            ? Map<String, dynamic>.from(json)
            : const <String, dynamic>{};
        final data = response['data'];
        return BookingEntity.fromJson(
          data is Map
              ? Map<String, dynamic>.from(data)
              : const <String, dynamic>{},
          tab: initialBooking.status,
        );
      },
    );
    return response.data;
  }
}
