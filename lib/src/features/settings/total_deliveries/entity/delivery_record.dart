part of '../presentation/imports/presentation_imports.dart';

class DeliveryRecord {
  final String orderNumber;
  final String customerName;
  final int fee;
  final String date;

  const DeliveryRecord({
    required this.orderNumber,
    required this.customerName,
    required this.fee,
    required this.date,
  });

  static const samples = [
    DeliveryRecord(
      orderNumber: 'ORD-15300',
      customerName: 'سارة علي',
      fee: 50,
      date: '10 أغسطس 2026',
    ),
    DeliveryRecord(
      orderNumber: 'ORD-15284',
      customerName: 'وليد إبراهيم',
      fee: 65,
      date: '8 أغسطس 2026',
    ),
  ];
}
