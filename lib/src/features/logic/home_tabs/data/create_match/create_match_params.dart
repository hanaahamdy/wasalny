part of '../../create_match/presentation/imports/create_match_imports.dart';

class CreateMatchParams {
  final BookingType bookingType;
  final int stadiumId;
  final int otherTeamId;
  final DateTime startsAt;
  final double durationHours;

  const CreateMatchParams({
    this.bookingType = BookingType.match,
    required this.stadiumId,
    required this.otherTeamId,
    required this.startsAt,
    this.durationHours = 1,
  });

  Map<String, dynamic> toJson() => {
    'booking_type': bookingType.apiValue,
    'stadium_id': stadiumId,
    'date': _formatDate(startsAt),
    'start_time': _formatTime(startsAt),
    'duration_hours': durationHours,
    'other_team_id': otherTeamId,
  };

  static String _formatDate(DateTime value) =>
      '${value.year.toString().padLeft(4, '0')}-'
      '${value.month.toString().padLeft(2, '0')}-'
      '${value.day.toString().padLeft(2, '0')}';

  static String _formatTime(DateTime value) =>
      '${value.hour.toString().padLeft(2, '0')}:'
      '${value.minute.toString().padLeft(2, '0')}';
}
