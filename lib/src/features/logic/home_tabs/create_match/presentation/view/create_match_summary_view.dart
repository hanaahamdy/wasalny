part of '../imports/create_match_imports.dart';

class CreateMatchSummaryView extends StatefulWidget {
  final CreateMatchSummaryModel summary;

  const CreateMatchSummaryView({super.key, required this.summary});

  @override
  State<CreateMatchSummaryView> createState() => _CreateMatchSummaryViewState();
}

class _CreateMatchSummaryViewState extends State<CreateMatchSummaryView> {
  late final CreateMatchCubit _cubit = CreateMatchCubit(
    stadiumId: widget.summary.stadium.id,
    otherTeamId: widget.summary.opponent.id,
  );

  Future<void> _confirm() async {
    final success = await _cubit.submit(widget.summary.params);
    if (!success || !mounted) return;
    await successDialog(
      context: context,
      title: _cubit.state.data?.message.isNotEmpty == true
          ? _cubit.state.data!.message
          : LocaleKeys.dataUpdatedSuccessfully,
    );
    if (!mounted) return;
    Go.back();
    Go.back();
    Go.back();
    Go.back(true);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateMatchCubit, AsyncState<BaseModel?>>(
      bloc: _cubit,
      builder: (context, state) => BookingSummaryPage(
        source: BookingFormSource.createMatch,
        bookingType: widget.summary.bookingType,
        dateTime: widget.summary.dateTime,
        price: widget.summary.price,
        paymentMethod: widget.summary.payment,
        stadiumPreview: CreateMatchStadiumCard(
          stadium: widget.summary.stadium,
          isSelected: true,
          onTap: () {},
        ),
        isLoading: state.isLoading,
        onConfirm: _confirm,
      ),
    );
  }
}
