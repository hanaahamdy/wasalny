class DeliveryModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String location;
  final int ordersCount;
  final int deliveredCount;
  final bool isActive;

  const DeliveryModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.location,
    required this.ordersCount,
    required this.deliveredCount,
    required this.isActive,
  });

  static const samples = <DeliveryModel>[
    DeliveryModel(
      id: 'DEL-001',
      name: 'أحمد محمد',
      phone: '01012345678',
      email: 'ahmed@waslny.com',
      location: 'القاهرة، مدينة نصر',
      ordersCount: 38,
      deliveredCount: 31,
      isActive: true,
    ),
    DeliveryModel(
      id: 'DEL-002',
      name: 'محمود علي',
      phone: '01123456789',
      email: 'mahmoud@waslny.com',
      location: 'الجيزة، الدقي',
      ordersCount: 27,
      deliveredCount: 24,
      isActive: true,
    ),
    DeliveryModel(
      id: 'DEL-003',
      name: 'يوسف خالد',
      phone: '01234567890',
      email: 'youssef@waslny.com',
      location: 'القاهرة، المعادي',
      ordersCount: 19,
      deliveredCount: 16,
      isActive: false,
    ),
  ];
}
