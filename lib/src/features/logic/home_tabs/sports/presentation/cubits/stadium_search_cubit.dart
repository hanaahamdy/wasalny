part of '../../../stadiums/presentation/imports/stadiums_imports.dart';

class StadiumSearchCubit extends AsyncCubit<List<Stadium>?> {
  StadiumSearchCubit() : super(null);

  StadiumFilterParams _filters = const StadiumFilterParams();

  StadiumFilterParams get filters => _filters;

  Future<void> search([String? query]) async {
    await _searchStadiums(query: query, filters: _filters);
  }

  Future<void> searchBySport(int sportId, [String? query]) async {
    await _searchStadiums(sportId: sportId, query: query, filters: _filters);
  }

  Future<void> applyFilters(
    StadiumFilterParams filters, [
    String? query,
  ]) async {
    _filters = filters;
    await _searchStadiums(query: query, filters: filters);
  }

  Future<void> clearFilters([String? query]) async {
    _filters = const StadiumFilterParams();
    await _searchStadiums(query: query);
  }

  Future<void> _searchStadiums({
    String? query,
    int? sportId,
    StadiumFilterParams filters = const StadiumFilterParams(),
  }) async {
    setLoading();
    try {
      final parameters = <String, dynamic>{
        if (query?.trim().isNotEmpty == true) 'search': query!.trim(),
        if (sportId != null && sportId > 0) 'sport_id': sportId,
        ...filters.toQueryParameters(),
      };
      final response = await injector<NetworkService>().callApi<List<Stadium>>(
        NetworkRequest(
          method: RequestMethod.get,
          path: ApiConstants.stadiums,
          queryParameters: parameters,
        ),
        mapper: (json) {
          final data = _jsonMap(_jsonMap(json)['data']);
          return _jsonList(data['data']).map(Stadium.fromListJson).toList();
        },
      );
      setSuccess(data: response.data);
    } catch (error) {
      setError(errorMessage: error.toString());
    }
  }
}
