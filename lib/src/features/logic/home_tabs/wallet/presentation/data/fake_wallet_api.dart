part of '../wallet_feature.dart';

class _FakeWalletApi {
  static Future<WalletEntity> getWallet() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return WalletEntity(
      balance: 350,
      lastRecharge: 200,
      lastRechargeDate: LocaleKeys.bookingsWalletLastRechargeDate,
      country: LocaleKeys.bookingsCountryEgypt,
    );
  }
}
