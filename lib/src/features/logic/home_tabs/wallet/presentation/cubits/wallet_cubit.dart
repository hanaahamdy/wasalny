part of '../wallet_feature.dart';

class WalletCubit extends AsyncCubit<WalletEntity?> {
  WalletCubit() : super(null);

  Future<void> fetchWallet() async {
    setLoading();
    try {
      final wallet = await _FakeWalletApi.getWallet();
      setSuccess(data: wallet);
    } catch (error) {
      setError(errorMessage: error.toString(), showToast: false);
    }
  }
}
