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

  factory WorkflowCategory.fromJson(Map<String, dynamic> json) {
    return WorkflowCategory(
      name: json['product_name']?.toString() ?? '',
      count: int.tryParse(json['quantity']?.toString() ?? '') ?? 0,
      unitPrice: double.tryParse(json['price']?.toString() ?? '') ?? 0,
    );
  }

  double get total => count * unitPrice;
}

class WorkflowOrder {
  final int id;
  final String orderNumber;
  final String clientName;
  final List<WorkflowCategory> categories;
  final double? totalAmount;
  final double deliveryFee;
  final String createdAt;
  final bool facebookLiveRequested;
  final String facebookRequest;
  final WorkflowOrderStatus status;
  final String? clientNumber;

  const WorkflowOrder({
    required this.id,
    this.orderNumber = '',
    required this.clientName,
    required this.categories,
    this.totalAmount,
    this.deliveryFee = 0,
    this.createdAt = '',
    required this.facebookLiveRequested,
    required this.facebookRequest,
    required this.status,
    this.clientNumber,
  });

  factory WorkflowOrder.fromJson(Map<String, dynamic> json) {
    final customer = json['customer'] is Map
        ? Map<String, dynamic>.from(json['customer'] as Map)
        : const <String, dynamic>{};
    final items = json['items'] is List ? json['items'] as List : const [];

    return WorkflowOrder(
      id: json['id'] is num
          ? (json['id'] as num).toInt()
          : int.tryParse(json['id']?.toString() ?? '') ?? 0,
      orderNumber: json['order_number']?.toString() ?? '',
      clientName: customer['name']?.toString() ?? '',
      categories: items
          .whereType<Map>()
          .map(
            (item) =>
                WorkflowCategory.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList(growable: false),
      totalAmount: double.tryParse(json['total_amount']?.toString() ?? ''),
      deliveryFee: double.tryParse(json['delivery_fee']?.toString() ?? '') ?? 0,
      createdAt: json['created_at']?.toString() ?? '',
      facebookLiveRequested: false,
      facebookRequest: '',
      status: WorkflowOrderStatus.readyForPacking,
      clientNumber: customer['phone']?.toString(),
    );
  }

  double get totalPrice =>
      totalAmount ?? categories.fold(0, (sum, item) => sum + item.total);

  WorkflowOrder copyWith({WorkflowOrderStatus? status, String? clientNumber}) {
    return WorkflowOrder(
      id: id,
      orderNumber: orderNumber,
      clientName: clientName,
      categories: categories,
      totalAmount: totalAmount,
      deliveryFee: deliveryFee,
      createdAt: createdAt,
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
