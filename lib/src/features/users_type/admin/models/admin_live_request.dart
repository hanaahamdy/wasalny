class AdminLiveRequest {
  final int id;
  final String broadcastName;
  final String description;
  final String sellerName;
  final String sellerEmail;
  final String status;

  const AdminLiveRequest({
    required this.id,
    required this.broadcastName,
    required this.description,
    required this.sellerName,
    required this.sellerEmail,
    required this.status,
  });

  bool get isPending => status.trim().toLowerCase() == 'pending';

  factory AdminLiveRequest.fromJson(Map<String, dynamic> json) {
    final seller = _mapValue(
      json['sales'] ??
          json['seller'] ??
          json['vendor'] ??
          json['customer'] ??
          json['user'] ??
          json['buyer'] ??
          json['client'],
    );

    return AdminLiveRequest(
      id: _intValue(json['id']),
      broadcastName: _stringValue(
        json['broadcast_name'] ??
            json['live_name'] ??
            json['title'] ??
            json['name'] ??
            json['subject'],
      ),
      description: _stringValue(
        json['description'] ??
            json['details'] ??
            json['request'] ??
            json['content'] ??
            json['notes'],
      ),
      sellerName: _stringValue(
        json['seller_name'] ??
            json['vendor_name'] ??
            json['customer_name'] ??
            json['client_name'] ??
            seller?['name'],
      ),
      sellerEmail: _stringValue(
        json['seller_email'] ??
            json['vendor_email'] ??
            json['customer_email'] ??
            json['client_email'] ??
            json['email'] ??
            seller?['email'],
      ),
      status: _stringValue(json['status'] ?? json['state']),
    );
  }

  static Map<String, dynamic>? _mapValue(dynamic value) =>
      value is Map ? Map<String, dynamic>.from(value) : null;

  static String _stringValue(dynamic value) => value?.toString().trim() ?? '';

  static int _intValue(dynamic value) =>
      value is int ? value : int.tryParse(value?.toString() ?? '') ?? 0;
}
