enum WorkflowOrderStatus {
  waitingAdmin,
  readyForPacking,
  readyForAliaa,
  completed,
}

enum WorkflowLiveStatus { waitingAdmin, approved, started }

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

  WorkflowOrder copyWith({WorkflowOrderStatus? status, String? clientNumber}) {
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

class WorkflowLiveRequest {
  final int id;
  final String clientName;
  final String details;
  final WorkflowLiveStatus status;

  const WorkflowLiveRequest({
    required this.id,
    required this.clientName,
    required this.details,
    required this.status,
  });

  WorkflowLiveRequest copyWith({WorkflowLiveStatus? status}) {
    return WorkflowLiveRequest(
      id: id,
      clientName: clientName,
      details: details,
      status: status ?? this.status,
    );
  }
}
