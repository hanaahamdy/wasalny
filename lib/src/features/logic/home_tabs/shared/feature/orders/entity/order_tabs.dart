enum AdminOrderTab {
  pending('معلق'),
  created('تم الانشاء'),
  delivering('قيد التوصيل'),
  received('تم الاستلام');

  final String label;

  const AdminOrderTab(this.label);
}

enum DeliveryOrderTab {
  created('تم الانشاء'),
  delivering('قيد التوصيل'),
  delivered('تم التسليم');

  final String label;

  const DeliveryOrderTab(this.label);
}
