part of '../wallet_feature.dart';

class ChargeWalletCubit extends AsyncCubit<BaseModel?> {
  final WalletCubit walletCubit;

  ChargeWalletCubit(this.walletCubit) : super(null);

  Future<void> charge(double amount) async {
    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.chargeWallet,
          httpRequestType: HttpRequestType.post,
          body: {'amount': amount, 'payment_method': 'online'},
          mapper: (json) =>
              BaseModel.fromJson(Map<String, dynamic>.from(json as Map)),
        ),
      ),
      successEmitter: (_) => walletCubit.fetchWallet(),
    );
  }
}
