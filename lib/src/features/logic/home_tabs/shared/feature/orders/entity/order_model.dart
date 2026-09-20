import 'order_tabs.dart';

class OrderModel {
  final int? backendId;
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
    this.backendId,
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
    final customer = json['customer'] is Map
        ? Map<String, dynamic>.from(json['customer'] as Map)
        : const <String, dynamic>{};
    final orderItems = json['items'] is List
        ? (json['items'] as List)
              .whereType<Map>()
              .map((item) => Map<String, dynamic>.from(item))
              .toList()
        : const <Map<String, dynamic>>[];
    final status = json['status']?.toString().toLowerCase();

    final adminTab = switch (status) {
      'on_hold' || 'on_holding' => AdminOrderTab.onHolding,
      'created' => AdminOrderTab.created,
      'delivering' || 'in_delivery' => AdminOrderTab.delivering,
      'received' || 'delivered' => AdminOrderTab.received,
      'cancelled' || 'canceled' => AdminOrderTab.cancelled,
      _ => AdminOrderTab.pending,
    };

    final deliveryTab = switch (status) {
      'delivering' || 'in_delivery' => DeliveryOrderTab.delivering,
      'received' || 'delivered' => DeliveryOrderTab.delivered,
      _ => DeliveryOrderTab.created,
    };

    final pieces = orderItems.fold<int>(
      0,
      (sum, item) =>
          sum + (int.tryParse(item['quantity']?.toString() ?? '') ?? 0),
    );

    return OrderModel(
      backendId: json['id'] is num
          ? (json['id'] as num).toInt()
          : int.tryParse(json['id']?.toString() ?? ''),
      id: json['order_number']?.toString() ?? json['id']?.toString() ?? '',
      customerName: customer['name']?.toString() ?? '',
      phone: customer['phone']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      date: json['created_at']?.toString() ?? '',
      total: json['total_amount']?.toString() ?? '0',
      paymentMethod: json['payment_method']?.toString() ?? '',
      productName: orderItems.isEmpty
          ? ''
          : orderItems.first['product_name']?.toString() ?? '',
      piecesCount: pieces.toString(),
      deliveryFee: json['delivery_fee']?.toString() ?? '0',
      adminTab: adminTab,
      deliveryTab: deliveryTab,
      items: orderItems
          .map((item) => item['product_name']?.toString() ?? '')
          .where((name) => name.isNotEmpty)
          .toList(),
    );
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
      adminTab: AdminOrderTab.onHolding,
      deliveryTab: DeliveryOrderTab.created,
      items: ['Small parcel', 'Doorstep delivery'],
    ),
    OrderModel(
      id: '#1028',
      customerName: 'Omar Adel',
      phone: '01098765432',
      address: 'Cairo',
      createdAt: '11:45 AM',
      date: '15 August 2026',
      total: '2,750 EGP',
      paymentMethod: 'Cash',
      productName: 'Package',
      piecesCount: '2 pieces',
      deliveryFee: '50 EGP',
      adminTab: AdminOrderTab.created,
      deliveryTab: DeliveryOrderTab.created,
      items: ['Package pickup', 'Doorstep delivery'],
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
