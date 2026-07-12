part of '../imports/stadiums_imports.dart';

class StadiumBookingView extends StatefulWidget {
  final Stadium stadium;

  const StadiumBookingView({super.key, required this.stadium});

  @override
  State<StadiumBookingView> createState() => _StadiumBookingViewState();
}

class _StadiumBookingViewState extends State<StadiumBookingView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateTimeController = TextEditingController();
  late final ValueNotifier<String> _selectedPaymentMethodNotifier =
      ValueNotifier<String>(LocaleKeys.stadiumsOnlinePayment);

  late final List<String> _bookingTypes = [
    LocaleKeys.stadiumsIndividualBooking,
    LocaleKeys.bookingsTeamMatch,
  ];

  String? _selectedBookingType;

  @override
  void dispose() {
    _dateTimeController.dispose();
    _selectedPaymentMethodNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppbar(title: LocaleKeys.bookingsBookFieldTitle) ,
      backgroundColor: AppColors.scaffoldBackground,
      bottomNavigationBar: _BookingConfirmButton(onConfirm: _confirm),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
            sliver: SliverList.list(
              children: [
                _BookingFormCard(
                  formKey: _formKey,
                  bookingTypes: _bookingTypes,
                  selectedBookingType: _selectedBookingType,
                  dateTimeController: _dateTimeController,
                  onBookingTypeChanged: (type) {
                    setState(() => _selectedBookingType = type);
                  },
                  onDateTimeTap: _selectDateTime,
                ),
                SizedBox(height: 16.h),
                _PaymentMethodsCard(
                  selectedPaymentMethodNotifier: _selectedPaymentMethodNotifier,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDateTime() async {
    final DateTime today = DateTime.now();
    final DateTime oneMonthFromToday = DateTime(
      today.year,
      today.month + 1,
      today.day,
    );

    await showCustomDatePicker(
      controller: _dateTimeController,
      dateFormat: 'EEE, M/d/y',
      initialDate: today,
      firstDate: today,
      lastDate: oneMonthFromToday,
    );
  }

  void _confirm() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    Go.to(BookingStadiumSummaryView(stadium: widget.stadium));
  }
}
