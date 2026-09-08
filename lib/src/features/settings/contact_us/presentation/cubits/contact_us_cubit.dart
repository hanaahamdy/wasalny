part of '../imports/contact_us_imports.dart';

@injectable
class ContactUsCubit extends Cubit<RequestState<BaseModel?>> {
  final ContactUsRepository _repository;

  ContactUsCubit(this._repository) : super(const RequestState(data: null));

  Future<void> contactUs(ContactUsParams params) async {
    if (state.isLoading || !params.validateAndScroll()) return;
    emit(state.copyWith(status: BaseStatus.loading, clearError: true));
    final result = await _repository.send(params);
    await result.when(
      (success) async {
        emit(state.copyWith(status: BaseStatus.success, data: success));
        final context = Go.context;
        if (!context.mounted) return;
        await successDialog(
          context: context,
          title: success?.message.isNotEmpty == true
              ? success!.message
              : LocaleKeys.contactRequestSendSuccessfully,
          afterSuccess: () => Go.back(true),
        );
      },
      (failure) async {
        emit(
          state.copyWith(
            status: BaseStatus.error,
            errorMessage: failure.message,
          ),
        );
        MessageUtils.showSnackBar(
          baseStatus: BaseStatus.error,
          message: failure.message,
        );
      },
    );
  }
}
