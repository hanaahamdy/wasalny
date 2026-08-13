part of '../imports/stadiums_imports.dart';

class BookingStadiumSummaryView extends StatefulWidget {
  final Stadium stadium;
  final BookingSummary summary;
  final CreateBookingParams params;

  const BookingStadiumSummaryView({
    super.key,
    required this.stadium,
    required this.summary,
    required this.params,
  });

  @override
  State<BookingStadiumSummaryView> createState() =>
      _BookingStadiumSummaryViewState();
}

class _BookingStadiumSummaryViewState extends State<BookingStadiumSummaryView> {
  late final CreateBookingCubit _cubit = CreateBookingCubit();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateBookingCubit, AsyncState<BookingSummary?>>(
      bloc: _cubit,
      builder: (context, state) => BookingSummaryPage(
        source: BookingFormSource.stadiumBooking,
        bookingType: widget.summary.type,
        dateTime: widget.summary.dateTime,
        price: widget.summary.price,
        paymentMethod: widget.summary.payment,
        stadiumPreview: StadiumCard(
          stadium: widget.stadium,
          compact: true,
          onDetails: () {},
        ),
        isLoading: state.isLoading,
        onConfirm: _confirmBooking,
      ),
    );
  }

  Future<void> _confirmBooking() async {
    final summary = await _cubit.createBooking(widget.params);
    if (summary == null || !mounted) {
      final message = _cubit.state.errorMessage;
      if (mounted && message?.isNotEmpty == true) {
        MessageUtils.showSnackBar(
          context: context,
          baseStatus: BaseStatus.error,
          message: message!,
        );
      }
      return;
    }
    await _showBookingSuccess(context);
    if (!context.mounted) return;
    await Go.offAll(const HomeScreen(initialTabIndex: 1));
  }
}
