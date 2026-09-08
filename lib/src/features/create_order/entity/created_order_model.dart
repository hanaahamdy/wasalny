class CreatedOrderModel {
  final int id;
  final int customerId;
  final String orderNumber;
  final String createdAt;
  final String updatedAt;

  const CreatedOrderModel({
    required this.id,
    required this.customerId,
    required this.orderNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreatedOrderModel.fromJson(Map<String, dynamic> json) =>
      CreatedOrderModel(
        id: (json['id'] as num?)?.toInt() ?? 0,
        customerId: (json['customer_id'] as num?)?.toInt() ?? 0,
        orderNumber: json['order_number']?.toString() ?? '',
        createdAt: json['created_at']?.toString() ?? '',
        updatedAt: json['updated_at']?.toString() ?? '',
      );
}

class CreateOrderResponse {
  final String message;
  final CreatedOrderModel order;

  const CreateOrderResponse({required this.message, required this.order});
}
