part of '../wallet_feature.dart';

class WalletCubit extends AsyncCubit<WalletEntity?> {
  WalletCubit() : super(null);

  Future<void> fetchWallet() async {
    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.wallet,
          httpRequestType: HttpRequestType.get,
          mapper: (json) => WalletEntity.fromJson(
            Map<String, dynamic>.from(json['data'] as Map),
          ),
        ),
      ),
    );
  }
}
