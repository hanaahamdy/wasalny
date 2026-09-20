import '../../../shared/feature/orders/entity/order_model.dart';

class DeliveryHomeModel {
  final int createdOrders;
  final int deliveredOrders;
  final List<OrderModel> latestOrders;

  const DeliveryHomeModel({
    required this.createdOrders,
    required this.deliveredOrders,
    required this.latestOrders,
  });

  factory DeliveryHomeModel.fromJson(Map<String, dynamic> json) {
    int parseCount(dynamic value) =>
        value is num ? value.toInt() : int.tryParse('$value') ?? 0;

    return DeliveryHomeModel(
      createdOrders: parseCount(json['created_orders']),
      deliveredOrders: parseCount(json['delivered_orders']),
      latestOrders: json['latest_orders'] is List
          ? (json['latest_orders'] as List)
                .whereType<Map>()
                .map(
                  (order) =>
                      OrderModel.fromJson(Map<String, dynamic>.from(order)),
                )
                .toList()
          : const [],
    );
  }
}
