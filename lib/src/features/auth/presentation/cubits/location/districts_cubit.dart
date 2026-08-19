part of '../../imports/view_imports.dart';

class DistrictsCubit extends AsyncCubit<List<DistrictEntity>> {
  DistrictsCubit() : super(const []);

  Future<void> fetchDistricts(int cityId) async {
    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams<List<DistrictEntity>>(
          api: ApiConstants.districts(cityId),
          httpRequestType: HttpRequestType.get,
          mapper: (json) {
            final response = Map<String, dynamic>.from(json as Map);
            final data = response['data'];
            final districtList = data is Map ? data['data'] : null;

            if (districtList is! List) return const [];
            return districtList
                .whereType<Map>()
                .map(
                  (district) => DistrictEntity.fromJson(
                    Map<String, dynamic>.from(district),
                  ),
                )
                .where(
                  (district) => district.id > 0 && district.name.isNotEmpty,
                )
                .toList();
          },
        ),
      ),
    );
  }

  void clear() => emit(const AsyncState(data: []));
}
