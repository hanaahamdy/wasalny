import 'package:flutter/foundation.dart';
import '../../../../config/language/locale_keys.g.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/network_request.dart';
import '../../../../core/network/network_service.dart';
import '../../../workflow/models/workflow_order.dart';

class AdminApprovalViewModel extends ChangeNotifier {
  final NetworkService _networkService;

  AdminApprovalViewModel(this._networkService);

  final List<WorkflowOrder> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;

  final List<WorkflowLiveRequest> _liveRequests = [
    const WorkflowLiveRequest(
      id: 2001,
      clientName: 'Nour Ahmed',
      details: 'New arrivals presentation',
      status: WorkflowLiveStatus.waitingAdmin,
    ),
    const WorkflowLiveRequest(
      id: 2002,
      clientName: 'Aya Mahmoud',
      details: 'Weekly products showcase',
      status: WorkflowLiveStatus.waitingAdmin,
    ),
  ];

  List<WorkflowOrder> get orders => List.unmodifiable(_orders);
  List<WorkflowLiveRequest> get liveRequests =>
      List.unmodifiable(_liveRequests);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadOrders() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _networkService.callApi<List<WorkflowOrder>>(
        NetworkRequest(
          path: ApiConstants.salesOrders,
          method: RequestMethod.get,
        ),
        mapper: _mapOrders,
      );
      _orders
        ..clear()
        ..addAll(response.data);
    } catch (error) {
      _errorMessage = _messageFor(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void approveOrder(int id) {
    _orders.removeWhere((order) => order.id == id);
    notifyListeners();
  }

  void approveLive(int id) {
    _liveRequests.removeWhere((request) => request.id == id);
    notifyListeners();
  }

  static List<WorkflowOrder> _mapOrders(dynamic json) {
    final root = json is Map ? Map<String, dynamic>.from(json) : null;
    final data = root?['data'];
    if (data is! List) return const [];

    return data
        .whereType<Map>()
        .map((item) => WorkflowOrder.fromJson(Map<String, dynamic>.from(item)))
        .toList(growable: false);
  }

  static String _messageFor(Object error) {
    final message = error.toString().trim();
    return message.isEmpty ? LocaleKeys.exceptionError : message;
  }
}
