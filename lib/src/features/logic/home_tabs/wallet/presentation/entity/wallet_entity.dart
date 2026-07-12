part of '../wallet_feature.dart';

class WalletEntity extends Equatable {
  final int balance;
  final int lastRecharge;
  final String lastRechargeDate;
  final String country;

  const WalletEntity({
    required this.balance,
    required this.lastRecharge,
    required this.lastRechargeDate,
    required this.country,
  });

  @override
  List<Object?> get props => [balance, lastRecharge, lastRechargeDate, country];
}
