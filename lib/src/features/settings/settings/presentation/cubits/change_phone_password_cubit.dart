part of '../imports/view_imports.dart';

class ChangePhonePasswordCubit extends AsyncCubit<BaseModel?> {
  ChangePhonePasswordCubit() : super(null);

  Future<void> startChangePhone({bool closeBottomSheet = false}) async {
    if (isLoading) return;
    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams<BaseModel?>(
          api: ApiConstants.changePhoneCurrentSend,
          httpRequestType: HttpRequestType.post,
          mapper: (json) => BaseModel.fromJson(json),
        ),
      ),
      successEmitter: (response) async {
        if (closeBottomSheet) Go.back();
        final message = response?.message;
        if (message?.isNotEmpty == true) {
          MessageUtils.showSnackBar(
            baseStatus: BaseStatus.success,
            message: message!,
          );
        }
        final isVerified = await Go.to<bool>(
          OtpVerificationScreen(
            phone: UserCubit.instance.user.phoneNumber,
            purpose: OtpPurpose.changePhone,
          ),
        );
        if (isVerified == true) Go.to(const ChangePhoneScreen());
      },
    );
  }

  Future<void> checkPassword(String _) =>
      startChangePhone(closeBottomSheet: true);
}
