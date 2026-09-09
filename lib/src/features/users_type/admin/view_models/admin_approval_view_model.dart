import 'package:flutter/foundation.dart';
import '../../../workflow/models/workflow_order.dart';

class AdminApprovalViewModel extends ChangeNotifier {
  final List<WorkflowOrder> _orders = [
    const WorkflowOrder(
      id: 1001,
      clientName: 'Mona Ali',
      categories: [
        WorkflowCategory(name: 'Clothes', count: 2, unitPrice: 320),
      ],
      facebookLiveRequested: false,
      facebookRequest: '',
      status: WorkflowOrderStatus.waitingAdmin,
    ),
    const WorkflowOrder(
      id: 1002,
      clientName: 'Sara Hassan',
      categories: [
        WorkflowCategory(name: 'Accessories', count: 4, unitPrice: 85),
      ],
      facebookLiveRequested: false,
      facebookRequest: '',
      status: WorkflowOrderStatus.waitingAdmin,
    ),
  ];

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
  List<WorkflowLiveRequest> get liveRequests => List.unmodifiable(_liveRequests);

  void approveOrder(int id) {
    _orders.removeWhere((order) => order.id == id);
    notifyListeners();
  }

  void approveLive(int id) {
    _liveRequests.removeWhere((request) => request.id == id);
    notifyListeners();
  }
}
