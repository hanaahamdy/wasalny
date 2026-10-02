import 'package:flutter/foundation.dart';
import '../../../../config/language/locale_keys.g.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/network_request.dart';
import '../../../../core/network/network_service.dart';
import '../../../workflow/models/workflow_order.dart';

class BuyerViewModel extends ChangeNotifier {
  final NetworkService? _networkService;

  BuyerViewModel([this._networkService]);

  final List<WorkflowOrder> _orders = [];
  final List<WorkflowLiveRequest> _liveRequests = [];
  bool _isSubmittingOrder = false;
  bool _isSubmittingLiveRequest = false;
  String? _orderError;
  String? _liveRequestError;

  List<WorkflowOrder> get orders => List.unmodifiable(_orders);
  List<WorkflowLiveRequest> get liveRequests =>
      List.unmodifiable(_liveRequests.reversed);
  bool get isSubmittingOrder => _isSubmittingOrder;
  bool get isSubmittingLiveRequest => _isSubmittingLiveRequest;
  String? get orderError => _orderError;
  String? get liveRequestError => _liveRequestError;

  Future<WorkflowOrder?> addOrder({
    required String clientName,
    required String clientPhone,
    required List<WorkflowCategory> categories,
  }) async {
    final networkService = _networkService;
    if (networkService == null || _isSubmittingOrder) return null;

    _isSubmittingOrder = true;
    _orderError = null;
    notifyListeners();

    try {
      final total = categories.fold<double>(
        0,
        (sum, category) => sum + category.total,
      );
      final body = <String, dynamic>{
        'name': clientName,
        'phone': clientPhone,
        'total_amount': total.toStringAsFixed(2),
        'delivery_fee': '0',
      };
      for (var index = 0; index < categories.length; index++) {
        final category = categories[index];
        body['products[$index][product_name]'] = category.name;
        body['products[$index][quantity]'] = category.count.toString();
        body['products[$index][price]'] = category.unitPrice.toStringAsFixed(2);
      }

      final response = await networkService.callApi<WorkflowOrder>(
        NetworkRequest(
          path: ApiConstants.salesOrders,
          method: RequestMethod.post,
          body: body,
          isFormData: true,
        ),
        mapper: (json) {
          final root = Map<String, dynamic>.from(json as Map);
          final rawData = root['data'];
          final data = rawData is Map
              ? Map<String, dynamic>.from(rawData)
              : const <String, dynamic>{};
          final rawId = data['id'];
          return WorkflowOrder(
            id: rawId is num
                ? rawId.toInt()
                : int.tryParse(rawId?.toString() ?? '') ??
                      DateTime.now().microsecondsSinceEpoch,
            orderNumber: data['order_number']?.toString() ?? '',
            clientName: clientName,
            categories: List.unmodifiable(categories),
            totalAmount: total,
            facebookLiveRequested: false,
            facebookRequest: '',
            status: WorkflowOrderStatus.waitingAdmin,
          );
        },
      );
      _orders.add(response.data);
      return response.data;
    } catch (error) {
      final message = error.toString().trim();
      _orderError = message.isEmpty ? LocaleKeys.exceptionError : message;
      return null;
    } finally {
      _isSubmittingOrder = false;
      notifyListeners();
    }
  }

  Future<WorkflowLiveRequest?> addLiveRequest({
    required String broadcastTitle,
    required String details,
  }) async {
    final networkService = _networkService;
    if (networkService == null || _isSubmittingLiveRequest) return null;

    _isSubmittingLiveRequest = true;
    _liveRequestError = null;
    notifyListeners();

    try {
      final response = await networkService.callApi<WorkflowLiveRequest>(
        NetworkRequest(
          path: ApiConstants.liveRequests,
          method: RequestMethod.post,
          body: {'title': broadcastTitle, 'description': details},
          isFormData: true,
        ),
        mapper: (json) => _mapCreatedLiveRequest(
          json,
          broadcastTitle: broadcastTitle,
          details: details,
        ),
      );
      _liveRequests.add(response.data);
      return response.data;
    } catch (error) {
      final message = error.toString().trim();
      _liveRequestError = message.isEmpty ? LocaleKeys.exceptionError : message;
      return null;
    } finally {
      _isSubmittingLiveRequest = false;
      notifyListeners();
    }
  }

  static WorkflowLiveRequest _mapCreatedLiveRequest(
    dynamic json, {
    required String broadcastTitle,
    required String details,
  }) {
    final root = json is Map ? Map<String, dynamic>.from(json) : null;
    final rawData = root?['data'];
    final data = rawData is Map
        ? Map<String, dynamic>.from(rawData)
        : const <String, dynamic>{};
    final rawId = data['id'];
    final id = rawId is num
        ? rawId.toInt()
        : int.tryParse(rawId?.toString() ?? '') ??
              DateTime.now().microsecondsSinceEpoch;

    return WorkflowLiveRequest(
      id: id,
      clientName:
          data['title']?.toString() ??
          data['broadcast_name']?.toString() ??
          broadcastTitle,
      details: data['description']?.toString() ?? details,
      status: WorkflowLiveStatus.waitingAdmin,
    );
  }

  void startLive(int id) {
    final index = _liveRequests.indexWhere((request) => request.id == id);
    if (index < 0) return;
    _liveRequests[index] = _liveRequests[index].copyWith(
      status: WorkflowLiveStatus.started,
    );
    notifyListeners();
  }
}
