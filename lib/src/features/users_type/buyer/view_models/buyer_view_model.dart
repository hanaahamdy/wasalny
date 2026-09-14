import 'package:flutter/foundation.dart';
import '../../../workflow/models/workflow_order.dart';

class BuyerViewModel extends ChangeNotifier {
  final List<WorkflowOrder> _orders = [];
  final List<WorkflowLiveRequest> _liveRequests = [];

  List<WorkflowOrder> get orders => List.unmodifiable(_orders);
  List<WorkflowLiveRequest> get liveRequests =>
      List.unmodifiable(_liveRequests.reversed);

  void addOrder({
    required String clientName,
    required List<WorkflowCategory> categories,
  }) {
    _orders.add(
      WorkflowOrder(
        id: DateTime.now().microsecondsSinceEpoch,
        clientName: clientName,
        categories: List.unmodifiable(categories),
        facebookLiveRequested: false,
        facebookRequest: '',
        status: WorkflowOrderStatus.waitingAdmin,
      ),
    );
    notifyListeners();
  }

  WorkflowLiveRequest addLiveRequest({
    required String clientName,
    required String details,
  }) {
    final request = WorkflowLiveRequest(
      id: DateTime.now().microsecondsSinceEpoch,
      clientName: clientName,
      details: details,
      status: WorkflowLiveStatus.waitingAdmin,
    );
    _liveRequests.add(request);
    notifyListeners();
    return request;
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
