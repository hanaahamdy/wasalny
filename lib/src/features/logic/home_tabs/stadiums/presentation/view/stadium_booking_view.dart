part of '../imports/stadiums_imports.dart';

class StadiumBookingView extends StatefulWidget {
  final Stadium stadium;

  const StadiumBookingView({super.key, required this.stadium});

  @override
  State<StadiumBookingView> createState() => _StadiumBookingViewState();
}

class _StadiumBookingViewState extends State<StadiumBookingView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fromDateTimeController = TextEditingController();
  final TextEditingController _toDateTimeController = TextEditingController();
  final ValueNotifier<BookingPaymentMethod> _selectedPaymentMethodNotifier =
      ValueNotifier(BookingPaymentMethod.online);

  BookingType? _selectedBookingType;
  DateTime? _startsAt;
  DateTime? _endsAt;

  @override
  void dispose() {
    _fromDateTimeController.dispose();
    _toDateTimeController.dispose();
    _selectedPaymentMethodNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateBookingCubit(),
      child: Builder(
        builder: (context) => ValueListenableBuilder<BookingPaymentMethod>(
          valueListenable: _selectedPaymentMethodNotifier,
          builder: (context, selectedMethod, _) => BookingFormPage(
            source: BookingFormSource.stadiumBooking,
            formKey: _formKey,
            selectedBookingType: _selectedBookingType,
            fromDateTimeController: _fromDateTimeController,
            toDateTimeController: _toDateTimeController,
            onBookingTypeChanged: (type) {
              setState(() => _selectedBookingType = type);
            },
            onFromDateTimeTap: _selectStartSlot,
            onToDateTimeTap: _selectEndSlot,
            selectedPaymentMethod: selectedMethod,
            onPaymentMethodChanged: (method) =>
                _selectedPaymentMethodNotifier.value = method,
            bottomAction:
                BlocBuilder<CreateBookingCubit, AsyncState<BookingSummary?>>(
                  builder: (context, state) => _BookingConfirmButton(
                    isLoading: state.isLoading,
                    onConfirm: () => _confirm(context),
                  ),
                ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectStartSlot() async {
    final selection = await Go.to<StadiumSlotSelection>(
      StadiumSlotsView(stadiumId: widget.stadium.id),
    );
    if (selection == null || !mounted) return;
    setState(() {
      _startsAt = selection.startsAt;
      _endsAt = null;
      _fromDateTimeController.text = DateFormat(
        'yyyy-MM-dd HH:mm',
        'en',
      ).format(selection.startsAt);
      _toDateTimeController.clear();
    });
  }

  Future<void> _selectEndSlot() async {
    final startsAt = _startsAt;
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
    setState(() {
      _endsAt = selection.endsAt;
      _toDateTimeController.text = DateFormat(
        'yyyy-MM-dd HH:mm',
        'en',
      ).format(selection.endsAt);
    });
  }

  Future<void> _confirm(BuildContext context) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_startsAt == null || _endsAt == null || !_endsAt!.isAfter(_startsAt!)) {
      MessageUtils.showSnackBar(
        context: context,
        baseStatus: BaseStatus.error,
        message: LocaleKeys.stadiumsInvalidBookingPeriod,
      );
      return;
    }

    final payment = _selectedPaymentMethodNotifier.value;
    final params = CreateBookingParams(
      stadiumId: widget.stadium.id,
      bookingType: _selectedBookingType!,
      startsAt: _startsAt!,
      endsAt: _endsAt!,
      paymentType: payment.apiValue,
    );
    await Go.to(
      BookingStadiumSummaryView(
        stadium: widget.stadium,
        params: params,
        summary: BookingSummary.preview(
          params: params,
          stadium: widget.stadium,
          paymentMethod: payment,
        ),
      ),
    );
  }
}
