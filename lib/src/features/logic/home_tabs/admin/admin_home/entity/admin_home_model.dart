class AdminHomeModel {
  final int createdOrders;
  final int deliveredOrders;

  const AdminHomeModel({
    required this.createdOrders,
    required this.deliveredOrders,
  });

  factory AdminHomeModel.fromJson(Map<String, dynamic> json) {
    int parseCount(dynamic value) =>
        value is num ? value.toInt() : int.tryParse('$value') ?? 0;

    return AdminHomeModel(
      createdOrders: parseCount(json['created_orders']),
      deliveredOrders: parseCount(json['delivered_orders']),
    );
  }
}
