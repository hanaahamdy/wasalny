part of '../imports/contact_us_imports.dart';

@injectable
class ContactUsCubit extends AsyncCubit<BaseModel?> {
  ContactUsCubit() : super(null);

  Future<void> contactUs(ContactUsParams params) async {
    if (isLoading || !params.validateAndScroll()) return;
    await executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.contactUs,
          body: params.toJson(),
          httpRequestType: HttpRequestType.post,
          mapper: (json) => BaseModel.fromJson(json),
        ),
      ),
      successEmitter: (success) async {
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
    );
  }
}
