import '../../home_tabs/shared/feature/orders/entity/order_model.dart';

class HomeModel {
  final int createdOrders;
  final int deliveredOrders;
  final int deliveryCount;
  final int ordersCount;
  final List<OrderModel> latestOrders;

  const HomeModel({
    required this.createdOrders,
    required this.deliveredOrders,
    required this.deliveryCount,
    required this.ordersCount,
    required this.latestOrders,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    final latestOrdersJson = json['latest_orders'];
    return HomeModel(
      createdOrders: _toInt(json['created_orders']),
      deliveredOrders: _toInt(json['delivered_orders']),
      deliveryCount: _toInt(json['delivery_count']),
      ordersCount: _toInt(json['orders_count']),
      latestOrders: latestOrdersJson is List
          ? latestOrdersJson
                .whereType<Map>()
                .map(
                  (order) =>
                      OrderModel.fromJson(Map<String, dynamic>.from(order)),
                )
                .toList()
          : const [],
    );
  }

  static int _toInt(dynamic value) {
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
