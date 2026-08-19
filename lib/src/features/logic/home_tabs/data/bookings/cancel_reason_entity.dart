part of '../../bookings/presentation/bookings_feature.dart';

class CancelReasonEntity extends Equatable {
  final int id;
  final String title;
  final bool isSelected;

  const CancelReasonEntity({
    required this.id,
    required this.title,
    this.isSelected = false,
  });

  factory CancelReasonEntity.fromJson(Map<String, dynamic> json) {
    return CancelReasonEntity(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      title:
          (json['title'] ?? json['name'] ?? json['reason'] ?? json['value'])
              ?.toString() ??
          '',
    );
  }

  CancelReasonEntity copyWith({bool? isSelected}) {
    return CancelReasonEntity(
      id: id,
      title: title,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [id, title, isSelected];
}
