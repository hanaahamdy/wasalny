import 'package:flutter/foundation.dart';
import '../../../workflow/models/workflow_order.dart';

class PackingViewModel extends ChangeNotifier {
  final List<WorkflowOrder> _orders = [
    _order('Mariam Hassan', [
      const WorkflowCategory(name: 'Accessories', count: 3, unitPrice: 120),
      const WorkflowCategory(name: 'Bags', count: 1, unitPrice: 450),
    ]),
    _order('Salma Ahmed', [
      const WorkflowCategory(name: 'Clothes', count: 4, unitPrice: 275),
    ]),
    _order('Nour Ali', [
      const WorkflowCategory(name: 'Home products', count: 2, unitPrice: 190),
    ]),
  ];

  List<WorkflowOrder> get orders => List.unmodifiable(_orders);

  void sendToAliaa(int id) {
    _orders.removeWhere((order) => order.id == id);
    notifyListeners();
  }

  static WorkflowOrder _order(String clientName, List<WorkflowCategory> categories) {
    return WorkflowOrder(
      id: DateTime.now().microsecondsSinceEpoch + clientName.hashCode,
      clientName: clientName,
      categories: List.unmodifiable(categories),
      facebookLiveRequested: false,
      facebookRequest: '',
      status: WorkflowOrderStatus.readyForPacking,
    );
  }
}
