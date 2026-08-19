part of '../../bookings_feature.dart';

class CancelBookingCubit extends AsyncCubit<String?> {
  final int bookingId;

  CancelBookingCubit({required this.bookingId}) : super(null);

  Future<void> cancel(CancelReasonEntity reason) async {
    if (isLoading) return;

    setLoading();
    try {
      final message = await _cancelBooking(reason.id);
      setSuccess(data: message);
    } catch (error) {
      setError(errorMessage: error.toString());
    }
  }

  Future<String> _cancelBooking(int reasonId) async {
    final response = await injector<NetworkService>().callApi<String>(
      NetworkRequest(
        method: RequestMethod.post,
        path: ApiConstants.cancelBooking(bookingId),
        body: {'cancel_reason_id': reasonId},
      ),
      mapper: (json) {
        final response = json is Map
            ? Map<String, dynamic>.from(json)
            : const <String, dynamic>{};
        return response['message']?.toString() ?? '';
      },
    );
    return response.data;
  }
}
