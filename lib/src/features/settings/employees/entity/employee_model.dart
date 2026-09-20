import '../../../../core/shared/models/employee_type.dart';

class EmployeeModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String location;
  final int ordersCount;
  final int deliveredCount;
  final bool isActive;
  final EmployeeType employeeType;

  const EmployeeModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.location,
    required this.ordersCount,
    required this.deliveredCount,
    required this.isActive,
    this.employeeType = EmployeeType.delivery,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    final role = json['role']?.toString() ?? '';
    return EmployeeModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      location: json['address']?.toString() ?? '',
      ordersCount: _asInt(json['orders_count']),
      deliveredCount: _asInt(json['delivered_count']),
      isActive: json['is_active'] == true || json['is_active'] == 1,
      employeeType: EmployeeType.values.firstWhere(
        (type) => type.apiValue == role,
        orElse: () => EmployeeType.delivery,
      ),
    );
  }

  EmployeeModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? location,
    bool? isActive,
  }) => EmployeeModel(
    id: id,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    email: email ?? this.email,
    location: location ?? this.location,
    ordersCount: ordersCount,
    deliveredCount: deliveredCount,
    isActive: isActive ?? this.isActive,
    employeeType: employeeType,
  );

  static int _asInt(dynamic value) => switch (value) {
    final int number => number,
    final String text => int.tryParse(text) ?? 0,
    _ => 0,
  };

  static const samples = <EmployeeModel>[
    EmployeeModel(
      id: 'DEL-001',
      name: 'أحمد محمد',
      phone: '01012345678',
      email: 'ahmed@waslny.com',
      location: 'القاهرة، مدينة نصر',
      ordersCount: 38,
      deliveredCount: 31,
      isActive: true,
    ),
    EmployeeModel(
      id: 'DEL-002',
      name: 'محمود علي',
      phone: '01123456789',
      email: 'mahmoud@waslny.com',
      location: 'الجيزة، الدقي',
      ordersCount: 27,
      deliveredCount: 24,
      isActive: true,
    ),
    EmployeeModel(
      id: 'DEL-003',
      name: 'يوسف خالد',
      phone: '01234567890',
      email: 'youssef@waslny.com',
      location: 'القاهرة، المعادي',
      ordersCount: 19,
      deliveredCount: 16,
      isActive: false,
    ),
    EmployeeModel(
      id: 'BUY-001',
      name: 'Mariam Hassan',
      phone: '01045678901',
      email: 'mariam@waslny.com',
      location: 'Cairo',
      ordersCount: 24,
      deliveredCount: 20,
      isActive: true,
      employeeType: EmployeeType.buyer,
    ),
    EmployeeModel(
      id: 'PAC-001',
      name: 'Omar Ali',
      phone: '01156789012',
      email: 'omar@waslny.com',
      location: 'Giza',
      ordersCount: 31,
      deliveredCount: 29,
      isActive: true,
      employeeType: EmployeeType.packer,
    ),
    EmployeeModel(
      id: 'ALI-001',
      name: 'Aliaa Mahmoud',
      phone: '01267890123',
      email: 'aliaa@waslny.com',
      location: 'Cairo',
      ordersCount: 18,
      deliveredCount: 18,
      isActive: true,
      employeeType: EmployeeType.alia,
    ),
  ];

  static List<EmployeeModel> samplesFor(EmployeeType type) =>
      samples.where((employee) => employee.employeeType == type).toList();
}
