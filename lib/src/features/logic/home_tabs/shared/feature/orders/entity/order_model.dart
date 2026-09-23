import 'order_tabs.dart';

class OrderModel {
  final String id;
  final String customerName;
  final String phone;
  final String address;
  final String createdAt;
  final String date;
  final String total;
  final String paymentMethod;
  final String productName;
  final String piecesCount;
  final String deliveryFee;
  final AdminOrderTab adminTab;
  final DeliveryOrderTab deliveryTab;
  final List<String> items;

  const OrderModel({
    required this.id,
    required this.customerName,
    required this.phone,
    required this.address,
    required this.createdAt,
    required this.date,
    required this.total,
    required this.paymentMethod,
    required this.productName,
    required this.piecesCount,
    required this.deliveryFee,
    required this.adminTab,
    required this.deliveryTab,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final customer = json['customer'];
    final customerJson = customer is Map
        ? Map<String, dynamic>.from(customer)
        : <String, dynamic>{};
    final rawItems = json['items'];
    final itemMaps = rawItems is List
        ? rawItems.whereType<Map>().map(Map<String, dynamic>.from).toList()
        : <Map<String, dynamic>>[];
    final status = json['status']?.toString().trim().toLowerCase() ?? '';

    return OrderModel(
      id: (json['order_number'] ?? json['id'])?.toString() ?? '',
      customerName: customerJson['name']?.toString() ?? '',
      phone: customerJson['phone']?.toString() ?? '',
      address: customerJson['address']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      date: json['created_at']?.toString() ?? '',
      total: json['total_amount']?.toString() ?? '',
      paymentMethod: json['payment_method']?.toString() ?? '',
      productName: itemMaps.isNotEmpty
          ? itemMaps.first['product_name']?.toString() ?? ''
          : '',
      piecesCount: itemMaps
          .fold<int>(
            0,
            (count, item) =>
                count + (int.tryParse(item['quantity']?.toString() ?? '') ?? 0),
          )
          .toString(),
      deliveryFee: json['delivery_fee']?.toString() ?? '',
      adminTab: _adminTabFromStatus(status),
      deliveryTab: _deliveryTabFromStatus(status),
      items: itemMaps
          .map((item) => item['product_name']?.toString() ?? '')
          .where((name) => name.isNotEmpty)
          .toList(),
    );
  }

  String get displayOrderNumber {
    if (id.startsWith('#')) return id;
    return '#$id';
  }

  static AdminOrderTab _adminTabFromStatus(String status) {
    return switch (status) {
      'created' => AdminOrderTab.created,
      'in_delivery' || 'delivering' => AdminOrderTab.delivering,
      'delivered' || 'received' => AdminOrderTab.received,
      'cancelled' || 'canceled' => AdminOrderTab.cancelled,
      _ => AdminOrderTab.pending,
    };
  }

  static DeliveryOrderTab _deliveryTabFromStatus(String status) {
    return switch (status) {
      'in_delivery' || 'delivering' => DeliveryOrderTab.delivering,
      'delivered' => DeliveryOrderTab.delivered,
      'received' => DeliveryOrderTab.recieved,
      _ => DeliveryOrderTab.created,
    };
  }

  static const samples = [
    OrderModel(
      id: '#1024',
      customerName: 'Ahmed Mohamed',
      phone: '01012345678',
      address: 'شارع التحرير القاهرة',
      createdAt: '10:30 AM',
      date: '15 أغسطس 2026',
      total: '4,500 جنيه',
      paymentMethod: 'كاش',
      productName: 'هاتف سامسونج Galaxy S24',
      piecesCount: '1 قطعة',
      deliveryFee: '50 جنيه',
      adminTab: AdminOrderTab.pending,
      deliveryTab: DeliveryOrderTab.created,
      items: ['Package pickup', 'Express delivery', 'Cash collection'],
    ),
    OrderModel(
      id: '#1025',
      customerName: 'Sara Ali',
      phone: '01012345678',
      address: 'شارع التحرير القاهرة',
      createdAt: '11:15 AM',
      date: '15 أغسطس 2026',
      total: '4,500 جنيه',
      paymentMethod: 'كاش',
      productName: 'هاتف سامسونج Galaxy S24',
      piecesCount: '1 قطعة',
      deliveryFee: '50 جنيه',
      adminTab: AdminOrderTab.created,
      deliveryTab: DeliveryOrderTab.created,
      items: ['Small parcel', 'Doorstep delivery'],
    ),
    OrderModel(
      id: '#1026',
      customerName: 'Khaled Omar',
      phone: '01012345678',
      address: 'شارع التحرير القاهرة',
      createdAt: '12:05 PM',
      date: '16 أغسطس 2026',
      total: '4,500 جنيه',
      paymentMethod: 'كاش',
      productName: 'هاتف سامسونج Galaxy S24',
      piecesCount: '1 قطعة',
      deliveryFee: '50 جنيه',
      adminTab: AdminOrderTab.delivering,
      deliveryTab: DeliveryOrderTab.delivering,
      items: ['Fragile package', 'Priority route'],
    ),
    OrderModel(
      id: '#1027',
      customerName: 'Mona Hassan',
      phone: '01012345678',
      address: 'شارع التحرير القاهرة',
      createdAt: '01:20 PM',
      date: '16 أغسطس 2026',
      total: '4,500 جنيه',
      paymentMethod: 'كاش',
      productName: 'هاتف سامسونج Galaxy S24',
      piecesCount: '1 قطعة',
      deliveryFee: '50 جنيه',
      adminTab: AdminOrderTab.received,
      deliveryTab: DeliveryOrderTab.delivered,
      items: ['Document delivery', 'Signature required'],
    ),
  ];
}
