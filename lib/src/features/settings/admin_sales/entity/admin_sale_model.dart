class AdminSaleModel {
  final String orderNumber;
  final String customerName;
  final int amount;

  const AdminSaleModel({
    required this.orderNumber,
    required this.customerName,
    required this.amount,
  });

  static const samples = <AdminSaleModel>[
    AdminSaleModel(
      orderNumber: 'ORD-1526#',
      customerName: 'سارة علي',
      amount: 3200,
    ),
    AdminSaleModel(
      orderNumber: 'ORD-1527#',
      customerName: 'عمر حسن',
      amount: 2800,
    ),
    AdminSaleModel(
      orderNumber: 'ORD-1530#',
      customerName: 'ريم الشافعي',
      amount: 9800,
    ),
  ];
}
