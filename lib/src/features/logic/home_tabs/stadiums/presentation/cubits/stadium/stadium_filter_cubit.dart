part of '../../imports/stadiums_imports.dart';

class StadiumFilterState {
  final SportCategory? sport;
  final CityEntity? city;
  final DistrictEntity? district;
  final List<SportCategory> sports;
  final List<CityEntity> cities;
  final List<DistrictEntity> districts;
  final bool isLoading;
  final bool isDistrictLoading;
  final String? errorMessage;

  const StadiumFilterState({
    this.sport,
    this.city,
    this.district,
    this.sports = const [],
    this.cities = const [],
    this.districts = const [],
    this.isLoading = true,
    this.isDistrictLoading = false,
    this.errorMessage,
  });

  factory StadiumFilterState.initial(StadiumFilterParams filters) {
    return StadiumFilterState(
      sport: filters.sport,
      city: filters.city,
      district: filters.district,
    );
  }

  StadiumFilterParams get filters =>
      StadiumFilterParams(sport: sport, city: city, district: district);

  StadiumFilterState copyWith({
    SportCategory? sport,
    CityEntity? city,
    DistrictEntity? district,
    List<SportCategory>? sports,
    List<CityEntity>? cities,
    List<DistrictEntity>? districts,
    bool? isLoading,
    bool? isDistrictLoading,
    String? errorMessage,
    bool clearSport = false,
    bool clearCity = false,
    bool clearDistrict = false,
    bool clearError = false,
  }) {
    return StadiumFilterState(
      sport: clearSport ? null : sport ?? this.sport,
      city: clearCity ? null : city ?? this.city,
      district: clearDistrict ? null : district ?? this.district,
      sports: sports ?? this.sports,
      cities: cities ?? this.cities,
      districts: districts ?? this.districts,
      isLoading: isLoading ?? this.isLoading,
      isDistrictLoading: isDistrictLoading ?? this.isDistrictLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}

class StadiumFilterCubit extends Cubit<StadiumFilterState> {
  StadiumFilterCubit({required StadiumFilterParams initialFilters})
    : super(StadiumFilterState.initial(initialFilters));

  Future<void> loadFilterData() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final results = await Future.wait([_loadSports(), _loadCities()]);
      emit(
        state.copyWith(
          sports: results[0] as List<SportCategory>,
          cities: results[1] as List<CityEntity>,
          isLoading: false,
        ),
      );
      final city = state.city;
      if (city != null) {
        await loadDistricts(city.id, keepSelected: true);
      }
    } catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
    }
  }

  void selectSport(SportCategory? sport) {
    emit(state.copyWith(sport: sport, clearSport: sport == null));
  }

  Future<void> selectCity(CityEntity? city) async {
    emit(
      state.copyWith(
        city: city,
        districts: const [],
        clearCity: city == null,
        clearDistrict: true,
      ),
    );
    if (city != null) {
      await loadDistricts(city.id);
    }
  }

  void selectDistrict(DistrictEntity? district) {
    emit(state.copyWith(district: district, clearDistrict: district == null));
  }

  void clearSelections() {
    emit(
      state.copyWith(
        districts: const [],
        isDistrictLoading: false,
        clearSport: true,
        clearCity: true,
        clearDistrict: true,
      ),
    );
  }

  Future<void> loadDistricts(int cityId, {bool keepSelected = false}) async {
    emit(state.copyWith(isDistrictLoading: true, clearDistrict: !keepSelected));
    try {
      final response = await injector<NetworkService>()
          .callApi<List<DistrictEntity>>(
            NetworkRequest(
              method: RequestMethod.get,
              path: ApiConstants.districts(cityId),
            ),
            mapper: (json) {
              final data = _jsonMap(json)['data'];
              final districts = data is Map ? data['data'] : data;
              return _jsonList(districts).map(DistrictEntity.fromJson).toList();
            },
          );
      emit(state.copyWith(districts: response.data, isDistrictLoading: false));
    } catch (_) {
      emit(state.copyWith(districts: const [], isDistrictLoading: false));
    }
  }

  Future<List<SportCategory>> _loadSports() async {
    final response = await injector<NetworkService>()
        .callApi<List<SportCategory>>(
          NetworkRequest(method: RequestMethod.get, path: ApiConstants.sports),
          mapper: (json) {
            final data = _jsonMap(json)['data'];
            return _jsonList(data).map(SportCategory.fromJson).toList();
          },
        );
    return response.data;
  }

  Future<List<CityEntity>> _loadCities() async {
    final response = await injector<NetworkService>().callApi<List<CityEntity>>(
      NetworkRequest(
        method: RequestMethod.get,
        path: ApiConstants.cities,
        queryParameters: const {'paginate': 100},
      ),
      mapper: (json) {
        final data = _jsonMap(json)['data'];
        final cities = data is Map ? data['data'] : data;
        return _jsonList(cities).map(CityEntity.fromJson).toList();
      },
    );
    return response.data;
  }
}
