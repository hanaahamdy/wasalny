part of '../../wallet/presentation/wallet_feature.dart';

class WalletEntity extends Equatable {
  final double balance;
  final double lastRecharge;
  final String lastRechargeDate;
  final String country;

  const WalletEntity({
    required this.balance,
    required this.lastRecharge,
    required this.lastRechargeDate,
    required this.country,
  });

  factory WalletEntity.fromJson(Map<String, dynamic> json) {
    final lastTopUp = json['last_topup'];
    final lastTopUpMap = lastTopUp is Map
        ? Map<String, dynamic>.from(lastTopUp)
        : const <String, dynamic>{};

    return WalletEntity(
      balance: (json['balance'] as num?)?.toDouble() ?? 0,
      lastRecharge: (lastTopUpMap['amount'] as num?)?.toDouble() ?? 0,
      lastRechargeDate:
          lastTopUpMap['created_at']?.toString() ?? ConstantManager.emptyText,
      country: ConstantManager.emptyText,
    );
  }

  @override
  List<Object?> get props => [balance, lastRecharge, lastRechargeDate, country];
}
