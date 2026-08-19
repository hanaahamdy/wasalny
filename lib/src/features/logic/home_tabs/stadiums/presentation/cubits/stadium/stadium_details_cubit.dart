part of '../../imports/stadiums_imports.dart';

class StadiumDetailsCubit extends AsyncCubit<Stadium?> {
  StadiumDetailsCubit() : super(null);

  Future<void> getStadium(int stadiumId) async {
    setLoading();
    try {
      final response = await injector<NetworkService>().callApi<Stadium>(
        NetworkRequest(
          method: RequestMethod.get,
          path: ApiConstants.stadiumDetails(stadiumId),
        ),
        mapper: (json) => Stadium.fromDetailsJson(_jsonMap(json)),
      );
      setSuccess(data: response.data);
    } catch (error) {
      setError(errorMessage: error.toString());
    }
  }
}
