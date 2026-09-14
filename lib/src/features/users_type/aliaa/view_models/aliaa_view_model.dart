import 'package:flutter/foundation.dart';
import '../../../workflow/models/workflow_order.dart';

class AliaaViewModel extends ChangeNotifier {
  final List<WorkflowOrder> _orders = [
    _order('Omar Ahmed', [
      const WorkflowCategory(name: 'Clothes', count: 2, unitPrice: 300),
    ]),
    _order('Hana Mahmoud', [
      const WorkflowCategory(name: 'Shoes', count: 1, unitPrice: 650),
      const WorkflowCategory(name: 'Accessories', count: 2, unitPrice: 90),
    ]),
    _order('Youssef Adel', [
      const WorkflowCategory(name: 'Home products', count: 3, unitPrice: 210),
    ]),
  ];

  List<WorkflowOrder> get orders => List.unmodifiable(_orders);

  void completeOrder(int id, String clientNumber) {
    _orders.removeWhere((order) => order.id == id);
    notifyListeners();
  }

  static WorkflowOrder _order(
    String clientName,
    List<WorkflowCategory> categories,
  ) {
    return WorkflowOrder(
      id: DateTime.now().microsecondsSinceEpoch + clientName.hashCode,
      clientName: clientName,
      categories: List.unmodifiable(categories),
      facebookLiveRequested: false,
      facebookRequest: '',
      status: WorkflowOrderStatus.readyForAliaa,
    );
  }
}
