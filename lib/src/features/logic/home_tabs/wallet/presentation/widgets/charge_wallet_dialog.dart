part of '../wallet_feature.dart';

Future<void> showChargeWalletDialog({required WalletCubit walletCubit}) {
  return showDialog<void>(
    context: Go.context,
    builder: (_) => BlocProvider(
      create: (_) => ChargeWalletCubit(walletCubit),
      child: const _ChargeWalletDialog(),
    ),
  );
}

class _ChargeWalletDialog extends StatefulWidget {
  const _ChargeWalletDialog();

  @override
  State<_ChargeWalletDialog> createState() => _ChargeWalletDialogState();
}

class _ChargeWalletDialogState extends State<_ChargeWalletDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _charge() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    await context.read<ChargeWalletCubit>().charge(
      double.parse(_amountController.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChargeWalletCubit, AsyncState<BaseModel?>>(
      listenWhen: (previous, current) =>
          previous.status != current.status && current.status.isSuccess,
      listener: (context, state) {
        Go.back();
        MessageUtils.showSnackBar(
          baseStatus: BaseStatus.success,
          message: state.data?.message ?? LocaleKeys.walletChargeSuccess,
        );
      },
      child: AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          LocaleKeys.bookingsRechargeBalance,
          textAlign: TextAlign.center,
        ),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: _amountController,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _charge(),
            decoration: InputDecoration(
              labelText: LocaleKeys.walletChargeAmount,
              hintText: LocaleKeys.walletChargeAmountHint,
              suffixText: LocaleKeys.bookingsRiyal,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            validator: (value) {
              final amount = double.tryParse(value?.trim() ?? '');
              if (amount == null || amount <= 0) {
                return LocaleKeys.walletChargeAmountError;
              }
              return null;
            },
          ),
        ),
        actionsPadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
        actions: [
          Row(
            children: [
              Expanded(
                child: LoadingButton(
                  title: LocaleKeys.cancel,
                  color: AppColors.white,
                  textColor: AppColors.main,
                  borderSide: const BorderSide(color: AppColors.border),
                  onTap: () async => Go.back(),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: LoadingButton(
                  title: LocaleKeys.bookingsRechargeBalance,
                  color: AppColors.authTabSelected,
                  onTap: _charge,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
