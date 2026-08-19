part of '../imports/create_match_imports.dart';

class CreateMatchCubit extends AsyncCubit<BaseModel?> {
  final int stadiumId;
  final int otherTeamId;

  CreateMatchCubit({required this.stadiumId, required this.otherTeamId})
    : super(null);

  final ValueNotifier<DateTime?> startsAtNotifier = ValueNotifier(null);
  final ValueNotifier<DateTime?> endsAtNotifier = ValueNotifier(null);
  final ValueNotifier<BookingPaymentMethod?> paymentNotifier = ValueNotifier(
    null,
  );
  final ValueNotifier<BookingType> bookingTypeNotifier = ValueNotifier(
    BookingType.match,
  );

  DateTime get firstAllowedDate {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  DateTime get lastAllowedDate =>
      firstAllowedDate.add(const Duration(days: 30));

  DateTime? dateValue({required bool isStart}) =>
      isStart ? startsAtNotifier.value : endsAtNotifier.value;

  DateTime get initialDate =>
      startsAtNotifier.value ?? endsAtNotifier.value ?? firstAllowedDate;

  bool get canSubmit =>
      startsAtNotifier.value != null &&
      endsAtNotifier.value != null &&
      paymentNotifier.value != null;

  void selectPayment(BookingPaymentMethod method) {
    paymentNotifier.value = method;
  }

  void selectBookingType(BookingType type) {
    bookingTypeNotifier.value = type;
  }

  void selectDateTime(DateTime value, {required bool isStart}) {
    if (isStart) {
      startsAtNotifier.value = value;
      if (endsAtNotifier.value != null &&
          !endsAtNotifier.value!.isAfter(value)) {
        endsAtNotifier.value = null;
      }
      return;
    }
    final startsAt = startsAtNotifier.value;
    if (startsAt != null && value.isAfter(startsAt)) {
      endsAtNotifier.value = value;
    }
  }

  String formatDateTime(DateTime value) => DateFormat(
    'yyyy/MM/dd - hh:mm a',
    Languages.currentLanguage.locale.languageCode,
  ).format(value);

  CreateMatchParams? buildParams() {
    final startsAt = startsAtNotifier.value;
    final endsAt = endsAtNotifier.value;
    if (startsAt == null || endsAt == null || !endsAt.isAfter(startsAt)) {
      return null;
    }
    final durationHours = endsAt.difference(startsAt).inMinutes / 60;
    if (durationHours > 12) return null;
    return CreateMatchParams(
      bookingType: bookingTypeNotifier.value,
      stadiumId: stadiumId,
      otherTeamId: otherTeamId,
      startsAt: startsAt,
      durationHours: durationHours,
    );
  }

  Future<bool> submit(CreateMatchParams params) async {
    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams<BaseModel?>(
          api: ApiConstants.bookings,
          body: params.toJson(),
          httpRequestType: HttpRequestType.post,
          isFromData: true,
          mapper: (json) =>
              BaseModel.fromJson(Map<String, dynamic>.from(json as Map)),
        ),
      ),
    );
    return state.isSuccess;
  }

  @override
  Future<void> close() {
    startsAtNotifier.dispose();
    endsAtNotifier.dispose();
    paymentNotifier.dispose();
    bookingTypeNotifier.dispose();
    return super.close();
  }
}
