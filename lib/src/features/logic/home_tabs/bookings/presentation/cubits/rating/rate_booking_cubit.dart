part of '../../bookings_feature.dart';

class RateBookingCubit extends AsyncCubit<String?> {
  final int bookingId;

  RateBookingCubit({required this.bookingId}) : super(null);

  Future<void> submit({required int rating, required String comment}) async {
    if (isLoading || rating < 1 || rating > 5) return;

    setLoading();
    try {
      final message = await _rateBooking(
        rating: rating,
        comment: comment.trim(),
      );
      setSuccess(data: message);
    } catch (error) {
      setError(errorMessage: error.toString());
    }
  }

  Future<String> _rateBooking({
    required int rating,
    required String comment,
  }) async {
    final response = await injector<NetworkService>().callApi<String>(
      NetworkRequest(
        method: RequestMethod.post,
        path: ApiConstants.reviewBooking(bookingId),
        body: {'rating': rating, if (comment.isNotEmpty) 'comment': comment},
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
