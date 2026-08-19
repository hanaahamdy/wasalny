part of '../../../stadiums/presentation/imports/stadiums_imports.dart';

class StadiumsHomeCubit extends AsyncCubit<StadiumHomePayload?> {
  StadiumsHomeCubit() : super(null);

  Future<void> loadHomePayload() async {
    setLoading();
    try {
      final response = await injector<NetworkService>()
          .callApi<StadiumHomePayload>(
            NetworkRequest(method: RequestMethod.get, path: ApiConstants.home),
            mapper: (json) => StadiumHomePayload.fromJson(_jsonMap(json)),
          );
      setSuccess(data: response.data);
    } catch (error) {
      setError(errorMessage: error.toString());
    }
  }
}
