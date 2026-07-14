part of 'notification_service.dart';

enum NotificationType {
  // Admin Notifications
  adminNotify("admin_notify", NoAction()),
  adminUserBlocked("admin_user_blocked", NoAction()),
  // User Status
  block("block", NoAction()),
  blockNotify("block_notify", NoAction()),
  deleteNotify("delete_notify", NoAction()),
  newTeam("new_team", NewTeamScreenAction()),
  confirmBooking("confirm_booking", ConfirmBookingScreenAction()),
  userBlocked("user_blocked", NoAction()),

  // Chat
  chat("new_message", ChatScreenAction());

  final String key;
  final NotificationNavigation action;

  const NotificationType(this.key, this.action);
}

extension NotificationTypeExtension on String {
  NotificationType? get toNotification => NotificationType.values
      .where((element) => element.key == this)
      .firstOrNull;
}

abstract interface class NotificationNavigation {
  const NotificationNavigation();

  void navigate({required Map<String, dynamic> data});
}

class NoAction implements NotificationNavigation {
  const NoAction();

  @override
  void navigate({required Map<String, dynamic> data}) {
    return;
  }
}

class ChatScreenAction implements NotificationNavigation {
  const ChatScreenAction();

  @override
  void navigate({required Map<String, dynamic> data}) {
    // Extract chat details from notification data
    final receiverId =
        num.tryParse(data["receiver_id"]?.toString() ?? "")?.toInt() ?? 0;
    // final roomId = num.tryParse(data["room_id"]?.toString() ?? "")?.toInt();
    // final receiverName = data["sender_name"]?.toString() ?? '';
    // final receiverImage = data["avatar"]?.toString() ?? '';

    if (receiverId > 0) {
      // Go.to(
      //   ChatDetailsScreen(
      //     receiverId: receiverId,
      //     receiverName: receiverName,
      //     receiverImage: receiverImage,
      //     roomId: roomId,
      //   ),
      // );
    }
  }
}

class NewTeamScreenAction implements NotificationNavigation {
  const NewTeamScreenAction();

  @override
  void navigate({required Map<String, dynamic> data}) {
    Go.to(const TeamDetailsView());
  }
}

class ConfirmBookingScreenAction implements NotificationNavigation {
  const ConfirmBookingScreenAction();

  @override
  void navigate({required Map<String, dynamic> data}) {
    Go.to(BookingDetailsForNotificationScreen(booking: _bookingFrom(data)));
  }

  BookingEntity _bookingFrom(Map<String, dynamic> data) {
    final total =
        num.tryParse(
          (data['total'] ?? data['price'] ?? data['amount'] ?? '150')
              .toString(),
        )?.toInt() ??
        150;

    return BookingEntity(
      id: num.tryParse(data['booking_id']?.toString() ?? '')?.toInt() ?? 0,
      code: data['booking_code']?.toString() ?? '',
      title: data['stadium_name']?.toString() ?? LocaleKeys.stadiumsNakheelName,
      type: data['booking_type']?.toString() ?? LocaleKeys.bookingsTeamMatch,
      location:
          data['stadium_location']?.toString() ??
          LocaleKeys.stadiumsNakheelLocation,
      date: data['booking_date']?.toString() ?? '06/04/2026',
      time: data['booking_time']?.toString() ?? '09:00 م',
      duration: data['duration']?.toString() ?? '',
      hourPrice:
          num.tryParse(data['hour_price']?.toString() ?? '')?.toInt() ?? total,
      total: total,
      paymentMethod:
          data['payment_method']?.toString() ??
          LocaleKeys.stadiumsOnlinePayment,
      isPaid: false,
      status: BookingStatus.scheduled,
      imageUrl:
          data['stadium_image']?.toString() ??
          'https://images.unsplash.com/photo-1540379708242-14a809bef941?auto=format&fit=crop&w=1200&q=80',
      services: const [],
      bookedAt: '',
    );
  }
}
