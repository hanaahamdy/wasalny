part of '../imports/create_match_imports.dart';

class CreateMatchTeamsCubit extends AsyncCubit<List<CreateMatchTeam>> {
  CreateMatchTeamsCubit() : super(const []);

  int _currentPage = 0;
  int _lastPage = 1;
  bool _requestInProgress = false;

  bool get canLoadMore => _currentPage < _lastPage;

  Future<void> fetchTeams() async {
    if (_requestInProgress) return;
    _currentPage = 0;
    _lastPage = 1;
    await _fetchPage(1, replace: true);
  }

  Future<void> fetchMoreTeams() async {
    if (_requestInProgress || !canLoadMore) return;
    await _fetchPage(_currentPage + 1, replace: false);
  }

  Future<void> _fetchPage(int page, {required bool replace}) async {
    _requestInProgress = true;
    replace ? setLoading() : setLoadingMore();
    try {
      final response = await injector<NetworkService>()
          .callApi<CreateMatchTeamsPage>(
            NetworkRequest(
              method: RequestMethod.get,
              path: ApiConstants.bookingOpponents,
              queryParameters: {'page': page, 'per_page': 15},
            ),
            mapper: CreateMatchTeamsPageMapper.fromResponse,
          );
      final result = response.data;
      _currentPage = result.currentPage;
      _lastPage = result.lastPage;
      final teams = replace
          ? result.teams
          : <CreateMatchTeam>[
              ...state.data,
              ...result.teams.where(
                (team) => !state.data.any((existing) => existing.id == team.id),
              ),
            ];
      setSuccess(data: teams);
    } catch (error) {
      if (replace) {
        setError(errorMessage: error.toString());
      } else {
        setSuccess(data: state.data);
      }
    } finally {
      _requestInProgress = false;
    }
  }
}
