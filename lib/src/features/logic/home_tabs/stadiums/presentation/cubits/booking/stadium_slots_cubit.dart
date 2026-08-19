part of '../../imports/stadiums_imports.dart';

class StadiumSlotsCubit extends AsyncCubit<List<StadiumSlot>> {
  final int stadiumId;

  StadiumSlotsCubit({required this.stadiumId}) : super(const []);

  Future<void> fetchSlots(DateTime date) async {
    setLoading();
    try {
      final response = await injector<NetworkService>()
          .callApi<List<StadiumSlot>>(
            NetworkRequest(
              method: RequestMethod.get,
              path: ApiConstants.stadiumSlots(stadiumId),
              queryParameters: {
                'date': DateFormat('yyyy-MM-dd', 'en').format(date),
              },
            ),
            mapper: _mapSlots,
          );
      setSuccess(data: response.data);
    } catch (error) {
      setError(errorMessage: error.toString());
    }
  }

  List<StadiumSlot> _mapSlots(dynamic json) {
    final root = _jsonMap(json);
    final slots = _jsonList(_jsonMap(root['data'])['slots']);
    return slots.map(StadiumSlot.fromJson).toList();
  }
}
