part of '../bookings_feature.dart';

class CancelReasonEntity extends Equatable {
  final int id;
  final String title;
  final bool isSelected;

  const CancelReasonEntity({
    required this.id,
    required this.title,
    this.isSelected = false,
  });

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
