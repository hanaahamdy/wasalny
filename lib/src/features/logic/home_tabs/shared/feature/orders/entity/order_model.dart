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
