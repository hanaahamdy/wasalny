part of '../sports_feature.dart';

class SportsCubit extends AsyncCubit<List<SportCategory>?> {
  SportsCubit() : super(null);

  Future<void> loadSports() async {
    setLoading();
    try {
      final response = await injector<NetworkService>()
          .callApi<List<SportCategory>>(
            NetworkRequest(
              method: RequestMethod.get,
              path: ApiConstants.sports,
            ),
            mapper: (json) {
              final response = json is Map
                  ? Map<String, dynamic>.from(json)
                  : const <String, dynamic>{};
              final data = response['data'];
              if (data is! List) return const [];
              return data
                  .whereType<Map>()
                  .map(
                    (sport) => SportCategory.fromJson(
                      Map<String, dynamic>.from(sport),
                    ),
                  )
                  .toList();
            },
          );
      setSuccess(data: response.data);
    } catch (error) {
      setError(errorMessage: error.toString());
    }
  }
}
