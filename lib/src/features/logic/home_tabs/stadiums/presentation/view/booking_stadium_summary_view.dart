part of '../imports/stadiums_imports.dart';

class BookingStadiumSummaryView extends StatefulWidget {
  final Stadium stadium;

  const BookingStadiumSummaryView({super.key, required this.stadium});

  @override
  State<BookingStadiumSummaryView> createState() =>
      _BookingStadiumSummaryViewState();
}

class _BookingStadiumSummaryViewState extends State<BookingStadiumSummaryView> {
  late final BookingSummaryCubit _cubit = BookingSummaryCubit()
    ..createBooking(widget.stadium.id);

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar:CustomAppbar(title: LocaleKeys.stadiumsBookingSummary),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 14.h, 24.w, 18.h),
          child: DefaultButton(
            title: LocaleKeys.stadiumsConfirm,
            height: 56.h,
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(28.r),
            onTap: () => _showBookingSuccess(context),
          ),
        ),
        body:
            BlocBuilder<BookingSummaryCubit, StadiumCubitState<BookingSummary>>(
              builder: (context, state) {
                if (state.isLoading || state.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }

                if (state.isError) {
                  return _StadiumErrorView(
                    message: state.errorMessage,
                    onRetry: () => context
                        .read<BookingSummaryCubit>()
                        .createBooking(widget.stadium.id),
                  );
                }

                final summary = state.data!;
                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(24.w, 18.h, 24.w, 28.h),
                      sliver: SliverList.list(
                        children: [
                          _SummaryRow(
                            label: LocaleKeys.stadiumsBookingType,
                            value: summary.type,
                          ),
                          _SummaryRow(
                            label: LocaleKeys.stadiumsBookingDateTime,
                            value: summary.dateTime,
                          ),
                          _SummaryRow(
                            label: LocaleKeys.stadiumsPrice,
                            value: summary.price,
                          ),
                          _SummaryRow(
                            label: LocaleKeys.stadiumsPaymentMethod,
                            value: summary.payment,
                          ),
                          SizedBox(height: 16.h),
                          const _PaymentPolicyCard(),
                          SizedBox(height: 20.h),
                          StadiumCard(
                            stadium: widget.stadium,
                            compact: true,
                            onDetails: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
      ),
    );
  }
}
