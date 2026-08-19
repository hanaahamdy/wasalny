part of '../../imports/view_imports.dart';

class CitiesCubit extends PaginatedCubit<CityEntity> {
  @override
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(
    int page, {
    String? key,
  }) {
    return baseCrudUseCase.call(
      CrudBaseParams<Map<String, dynamic>>(
        api: ApiConstants.cities,
        httpRequestType: HttpRequestType.get,
        queryParameters: {'page': page, 'paginate': 30},
        mapper: (json) => Map<String, dynamic>.from(json as Map),
      ),
    );
  }

  @override
  List<CityEntity> parseItems(dynamic json) {
    final cities = json is Map ? json['data'] : null;
    if (cities is! List) return const [];

    return cities
        .whereType<Map>()
        .map((city) => CityEntity.fromJson(Map<String, dynamic>.from(city)))
        .where((city) => city.id > 0 && city.name.isNotEmpty)
        .toList();
  }

  @override
  PaginationMeta parsePagination(dynamic json) {
    final pagination = json is Map ? json['pagination'] : null;
    if (pagination is! Map) return PaginatedData<CityEntity>.initial().meta;

    int readInt(String key, [int fallback = 0]) =>
        int.tryParse(pagination[key]?.toString() ?? '') ?? fallback;

    final currentPage = readInt('current_page', 1);
    final perPage = readInt('per_page', 30);
    final total = readInt('total');
    final lastPage = readInt('last_page', 1);

    return PaginationMeta(
      totalItems: total,
      countItems: readInt('to') - readInt('from') + 1,
      perPage: perPage,
      totalPages: lastPage,
      currentPage: currentPage,
    );
  }
}
