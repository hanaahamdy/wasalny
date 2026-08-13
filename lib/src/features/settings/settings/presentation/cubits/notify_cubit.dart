part of '../imports/view_imports.dart';

@injectable
class NotifiyCubit extends AsyncCubit<BaseModel?> {
  NotifiyCubit() : super(null);

  Future<void> switchNotify(bool isEnabled) async {
    if (isLoading) return;
    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.switchNotification,
          body: {'is_notify': isEnabled},
          httpRequestType: HttpRequestType.put,
          mapper: (json) => BaseModel.fromJson(json),
        ),
      ),
      successEmitter: (success) async {
        MessageUtils.showSnackBar(
          baseStatus: BaseStatus.success,
          message: success!.message,
        );
        final user = UserCubit.instance.user.copyWith(allowNotify: isEnabled);
        await UserCubit.instance.updateUser(user);
      },
    );
  }
}
