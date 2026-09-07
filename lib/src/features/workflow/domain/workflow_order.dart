import 'package:flutter/foundation.dart';

enum WorkflowOrderStatus {
  waitingAdmin,
  readyForPacking,
  readyForAliaa,
  completed,
}

class WorkflowCategory {
  final String name;
  final int count;
  final double unitPrice;

  const WorkflowCategory({
    required this.name,
    required this.count,
    required this.unitPrice,
  });

  double get total => count * unitPrice;
}

class WorkflowOrder {
  final int id;
  final String clientName;
  final List<WorkflowCategory> categories;
  final bool facebookLiveRequested;
  final String facebookRequest;
  final WorkflowOrderStatus status;
  final String? clientNumber;

  const WorkflowOrder({
    required this.id,
    required this.clientName,
    required this.categories,
    required this.facebookLiveRequested,
    required this.facebookRequest,
    required this.status,
    this.clientNumber,
  });

  double get totalPrice => categories.fold(0, (sum, item) => sum + item.total);

  WorkflowOrder copyWith({
    WorkflowOrderStatus? status,
    String? clientNumber,
  }) {
    return WorkflowOrder(
      id: id,
      clientName: clientName,
      categories: categories,
      facebookLiveRequested: facebookLiveRequested,
      facebookRequest: facebookRequest,
      status: status ?? this.status,
      clientNumber: clientNumber ?? this.clientNumber,
    );
  }
}

class WorkflowStore extends ChangeNotifier {
  WorkflowStore._();

  static final WorkflowStore instance = WorkflowStore._();
  final List<WorkflowOrder> _orders = [];

  List<WorkflowOrder> get orders => List.unmodifiable(_orders.reversed);

  void addOrder({
    required String clientName,
    required List<WorkflowCategory> categories,
    required bool facebookLiveRequested,
    required String facebookRequest,
  }) {
    _orders.add(
      WorkflowOrder(
        id: DateTime.now().millisecondsSinceEpoch,
        clientName: clientName,
        categories: List.unmodifiable(categories),
        facebookLiveRequested: facebookLiveRequested,
        facebookRequest: facebookRequest,
        status: WorkflowOrderStatus.waitingAdmin,
      ),
    );
    notifyListeners();
  }

  void approve(int id) => _updateStatus(id, WorkflowOrderStatus.readyForPacking);

  void sendToAliaa(int id) => _updateStatus(id, WorkflowOrderStatus.readyForAliaa);

  void complete(int id, String clientNumber) {
    final index = _orders.indexWhere((order) => order.id == id);
    if (index < 0) return;
    _orders[index] = _orders[index].copyWith(
      status: WorkflowOrderStatus.completed,
      clientNumber: clientNumber,
    );
    notifyListeners();
  }

  void _updateStatus(int id, WorkflowOrderStatus status) {
    final index = _orders.indexWhere((order) => order.id == id);
    if (index < 0) return;
    _orders[index] = _orders[index].copyWith(status: status);
    notifyListeners();
  }
}
