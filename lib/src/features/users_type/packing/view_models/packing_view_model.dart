import 'package:flutter/foundation.dart';
import '../../../../config/language/locale_keys.g.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/network_request.dart';
import '../../../../core/network/network_service.dart';
import '../../../workflow/models/workflow_order.dart';

class PackingViewModel extends ChangeNotifier {
  final NetworkService _networkService;

  PackingViewModel(this._networkService);

  final List<WorkflowOrder> _orders = [];
  final Set<int> _sendingOrderIds = {};
  bool _isLoading = false;
  String? _errorMessage;

  List<WorkflowOrder> get orders => List.unmodifiable(_orders);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool isSending(int orderId) => _sendingOrderIds.contains(orderId);

  Future<void> loadOrders() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _networkService.callApi<List<WorkflowOrder>>(
        NetworkRequest(
          path: ApiConstants.packingOrders,
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

  Future<bool> sendToAliaa(int id) async {
    _sendingOrderIds.add(id);
    _errorMessage = null;
    notifyListeners();

    try {
      await _networkService.callApi(
        NetworkRequest(
          path: ApiConstants.sendOrderToAliya(id),
          method: RequestMethod.post,
        ),
      );
      _orders.removeWhere((order) => order.id == id);
      return true;
    } catch (error) {
      _errorMessage = _messageFor(error);
      return false;
    } finally {
      _sendingOrderIds.remove(id);
      notifyListeners();
    }
  }

  static List<WorkflowOrder> _mapOrders(dynamic json) {
    final root = json is Map ? Map<String, dynamic>.from(json) : null;
    final payload = root?['data'];
    final records = payload is Map ? payload['data'] : payload;
    if (records is! List) return const [];

    return records
        .whereType<Map>()
        .map((item) => WorkflowOrder.fromJson(Map<String, dynamic>.from(item)))
        .toList(growable: false);
  }

  static String _messageFor(Object error) {
    final message = error.toString().trim();
    return message.isEmpty ? LocaleKeys.exceptionError : message;
  }
}
