part of '../../presentation/imports/stadiums_imports.dart';

class StadiumSlot {
  final int? id;
  final String startTime;
  final String endTime;
  final String status;
  final bool isAvailable;

  const StadiumSlot({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.isAvailable,
  });

  factory StadiumSlot.fromJson(Map<String, dynamic> json) {
    final status = _jsonMap(json['status']);
    return StadiumSlot(
      id: int.tryParse(json['slot_id']?.toString() ?? ''),
      startTime: json['start_time']?.toString() ?? '',
      endTime: json['end_time']?.toString() ?? '',
      status: status['value']?.toString() ?? '',
      isAvailable: json['is_available'] == true,
    );
  }
}
