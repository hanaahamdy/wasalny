import '../../../shared/feature/orders/entity/order_model.dart';

class AdminHomeModel {
  final int ordersCount;
  final int deliveryCount;
  final List<OrderModel> latestOrders;

  const AdminHomeModel({
    required this.ordersCount,
    required this.deliveryCount,
    required this.latestOrders,
  });

  factory AdminHomeModel.fromJson(Map<String, dynamic> json) {
    int parseCount(dynamic value) =>
        value is num ? value.toInt() : int.tryParse('$value') ?? 0;

    return AdminHomeModel(
      ordersCount: parseCount(json['orders_count']),
      deliveryCount: parseCount(json['delivery_count']),
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
