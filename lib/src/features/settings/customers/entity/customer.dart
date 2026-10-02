class Customer {
  final int id;
  final String name;
  final String email;
  final String phone;

  const Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: switch (json['id']) {
      final int value => value,
      final String value => int.tryParse(value) ?? 0,
      _ => 0,
    },
    name: json['name']?.toString() ?? '',
    email: json['email']?.toString() ?? '',
    phone: json['phone']?.toString() ?? '',
  );
}
