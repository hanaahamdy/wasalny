part of '../imports/create_match_imports.dart';

class CreateMatchDateTimeView extends StatefulWidget {
  final CreateMatchTeam team;
  final CreateMatchStadium stadium;

  const CreateMatchDateTimeView({
    super.key,
    required this.team,
    required this.stadium,
  });

  @override
  State<CreateMatchDateTimeView> createState() =>
      _CreateMatchDateTimeViewState();
}

class _CreateMatchDateTimeViewState extends State<CreateMatchDateTimeView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fromDateTimeController = TextEditingController();
  final TextEditingController _toDateTimeController = TextEditingController();
  late final CreateMatchCubit _cubit = CreateMatchCubit(
    stadiumId: widget.stadium.id,
    otherTeamId: widget.team.id,
  );

  Future<void> _selectStartSlot() async {
    final selection = await Go.to<StadiumSlotSelection>(
      StadiumSlotsView(stadiumId: widget.stadium.id),
    );
    if (selection == null || !mounted) return;
    _cubit.selectDateTime(selection.startsAt, isStart: true);
    _fromDateTimeController.text = _cubit.formatDateTime(selection.startsAt);
    _toDateTimeController.clear();
  }

  Future<void> _selectEndSlot() async {
    final startsAt = _cubit.startsAtNotifier.value;
    if (startsAt == null) {
      MessageUtils.showSnackBar(
        context: context,
        baseStatus: BaseStatus.error,
        message: LocaleKeys.stadiumsInvalidBookingPeriod,
      );
      return;
    }
    final selection = await Go.to<StadiumSlotSelection>(
      StadiumSlotsView(stadiumId: widget.stadium.id, startsAt: startsAt),
    );
    if (selection == null || !mounted) return;
    _cubit.selectDateTime(selection.endsAt, isStart: false);
    _toDateTimeController.text = _cubit.formatDateTime(selection.endsAt);
  }

  Future<void> _submit() async {
    final params = _cubit.buildParams();
    final endsAt = _cubit.endsAtNotifier.value;
    final payment = _cubit.paymentNotifier.value;
    if (params == null || endsAt == null || payment == null) return;
    await Go.to(
      CreateMatchSummaryView(
        summary: CreateMatchSummaryModel(
          params: params,
          opponent: widget.team,
          stadium: widget.stadium,
          paymentMethod: payment,
          endsAt: endsAt,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fromDateTimeController.dispose();
    _toDateTimeController.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.createMatchHeader,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _cubit.startsAtNotifier,
          _cubit.endsAtNotifier,
          _cubit.paymentNotifier,
          _cubit.bookingTypeNotifier,
        ]),
        builder: (context, _) => BookingFormPage(
          source: BookingFormSource.createMatch,
          formKey: _formKey,
          selectedBookingType: _cubit.bookingTypeNotifier.value,
          fromDateTimeController: _fromDateTimeController,
          toDateTimeController: _toDateTimeController,
          onBookingTypeChanged: (type) {
            if (type != null) _cubit.selectBookingType(type);
          },
          onFromDateTimeTap: _selectStartSlot,
          onToDateTimeTap: _selectEndSlot,
          selectedPaymentMethod: _cubit.paymentNotifier.value,
          onPaymentMethodChanged: _cubit.selectPayment,
          bottomAction: CreateMatchBottomAction(
            enabled: _cubit.canSubmit,
            onNext: _submit,
          ),
        ),
      ),
    );
  }
}
