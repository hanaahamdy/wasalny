class CreateDeliveryParams {
  final String name;
  final String email;
  final String password;

  const CreateDeliveryParams({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
    'password_confirmation': password,
    'role': 'delivery',
  };
}
