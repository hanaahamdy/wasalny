import 'package:flutter/foundation.dart';

import '../../../../config/language/locale_keys.g.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/network_request.dart';
import '../../../../core/network/network_service.dart';
import '../models/admin_live_request.dart';

class AdminLiveRequestsViewModel extends ChangeNotifier {
  final NetworkService _networkService;

  AdminLiveRequestsViewModel(this._networkService);

  final List<AdminLiveRequest> _requests = [];
  bool _isLoading = false;
  String? _errorMessage;
  final Set<int> _processingRequestIds = {};

  List<AdminLiveRequest> get requests => List.unmodifiable(_requests);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool isProcessing(int requestId) => _processingRequestIds.contains(requestId);

  Future<void> loadRequests() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _networkService.callApi<List<AdminLiveRequest>>(
        NetworkRequest(
          path: ApiConstants.liveRequests,
          method: RequestMethod.get,
        ),
        mapper: _mapRequests,
      );
      _requests
        ..clear()
        ..addAll(response.data);
    } catch (error) {
      _errorMessage = error.toString().trim().isEmpty
          ? LocaleKeys.exceptionError
          : error.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  static List<AdminLiveRequest> _mapRequests(dynamic json) {
    final root = json is Map ? Map<String, dynamic>.from(json) : null;
    final payload = root?['data'];
    final records = payload is Map ? payload['data'] : payload;
    if (records is! List) return const [];

    return records
        .whereType<Map>()
        .map(
          (item) => AdminLiveRequest.fromJson(Map<String, dynamic>.from(item)),
        )
        .toList();
  }

  Future<bool> acceptRequest(int requestId) => _handleRequest(
    requestId: requestId,
    path: ApiConstants.acceptLiveRequest(requestId),
  );

  Future<bool> rejectRequest(int requestId) => _handleRequest(
    requestId: requestId,
    path: ApiConstants.rejectLiveRequest(requestId),
  );

  Future<bool> _handleRequest({
    required int requestId,
    required String path,
    Map<String, dynamic>? body,
  }) async {
    _processingRequestIds.add(requestId);
    notifyListeners();
    try {
      await _networkService.callApi(
        NetworkRequest(
          path: path,
          method: RequestMethod.post,
          body: body,
          isFormData: body != null,
        ),
      );
      await loadRequests();
      return true;
    } catch (error) {
      _errorMessage = error.toString().trim().isEmpty
          ? LocaleKeys.exceptionError
          : error.toString();
      return false;
    } finally {
      _processingRequestIds.remove(requestId);
      notifyListeners();
    }
  }
}
