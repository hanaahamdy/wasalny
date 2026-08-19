part of '../../imports/stadiums_imports.dart';

class CreateBookingCubit extends AsyncCubit<BookingSummary?> {
  CreateBookingCubit() : super(null);

  Future<BookingSummary?> createBooking(CreateBookingParams params) async {
    setLoading();
    try {
      final response = await injector<NetworkService>().callApi<BookingSummary>(
        NetworkRequest(
          method: RequestMethod.post,
          path: ApiConstants.bookings,
          body: params.toJson(),
          isFormData: true,
        ),
        mapper: (json) => BookingSummary.fromJson(_jsonMap(json)),
      );
      setSuccess(data: response.data);
      return response.data;
    } catch (error) {
      setError(errorMessage: error.toString());
      return null;
    }
  }
}
