part of '../bookings_feature.dart';

class BookingDetailsView extends StatelessWidget {
  final BookingEntity booking;

  const BookingDetailsView({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.subtleBackground,
        bottomNavigationBar: _BookingDetailsActionBar(booking: booking),
        body: _BookingDetailsBody(booking: booking),
      ),
    );
  }
}
