part of '../imports/view_imports.dart';

class CreateTeamSportsCubit extends AsyncCubit<List<CreateTeamSport>> {
  CreateTeamSportsCubit() : super(const []);

  Future<void> loadSports() async {
    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams<List<CreateTeamSport>>(
          api: ApiConstants.sports,
          httpRequestType: HttpRequestType.get,
          mapper: (json) {
            final response = Map<String, dynamic>.from(json as Map);
            final data = response['data'];
            if (data is! List) return const [];
            return data
                .whereType<Map>()
                .map(
                  (sport) => CreateTeamSport.fromJson(
                    Map<String, dynamic>.from(sport),
                  ),
                )
                .where((sport) => sport.id > 0 && sport.name.isNotEmpty)
                .toList();
          },
        ),
      ),
    );
  }
}
