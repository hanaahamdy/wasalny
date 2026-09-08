part of '../imports/view_imports.dart';

@injectable
class StaticPagesCubit extends Cubit<RequestState<String?>> {
  final StaticPagesRepository _repository;

  StaticPagesCubit(this._repository) : super(const RequestState(data: null));

  Future<void> fetchStaticPage(StaticPageTypeEnum pageType) async {
    emit(state.copyWith(status: BaseStatus.loading, clearError: true));
    final result = await _repository.fetch(pageType);
    result.when(
      (content) =>
          emit(state.copyWith(status: BaseStatus.success, data: content)),
      (failure) => emit(
        state.copyWith(status: BaseStatus.error, errorMessage: failure.message),
      ),
    );
  }
}
