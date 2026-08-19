part of '../imports/create_match_imports.dart';

class CreateMatchStadiumsCubit extends AsyncCubit<List<CreateMatchStadium>> {
  CreateMatchStadiumsCubit() : super(const []);

  int _currentPage = 0;
  int _lastPage = 1;
  bool _requestInProgress = false;

  bool get canLoadMore => _currentPage < _lastPage;

  Future<void> fetchStadiums() async {
    if (_requestInProgress) return;
    _currentPage = 0;
    _lastPage = 1;
    await _fetchPage(1, replace: true);
  }

  Future<void> fetchMoreStadiums() async {
    if (_requestInProgress || !canLoadMore) return;
    await _fetchPage(_currentPage + 1, replace: false);
  }

  Future<void> _fetchPage(int page, {required bool replace}) async {
    _requestInProgress = true;
    replace ? setLoading() : setLoadingMore();
    try {
      final response = await injector<NetworkService>()
          .callApi<CreateMatchStadiumsPage>(
            NetworkRequest(
              method: RequestMethod.get,
              path: ApiConstants.stadiums,
              queryParameters: {'page': page, 'per_page': 15},
            ),
            mapper: CreateMatchStadiumsPageMapper.fromResponse,
          );
      final result = response.data;
      _currentPage = result.currentPage;
      _lastPage = result.lastPage;
      final stadiums = replace
          ? result.stadiums
          : <CreateMatchStadium>[
              ...state.data,
              ...result.stadiums.where(
                (stadium) =>
                    !state.data.any((existing) => existing.id == stadium.id),
              ),
            ];
      setSuccess(data: stadiums);
    } catch (error) {
      replace
          ? setError(errorMessage: error.toString())
          : setSuccess(data: state.data);
    } finally {
      _requestInProgress = false;
    }
  }
}
