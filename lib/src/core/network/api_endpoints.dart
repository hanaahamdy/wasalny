class ApiConstants {
  // ---------------------- Settings -----------------------------------
  static const String intro = 'get-intros';
  static const String countries = 'countries';
  static const String uploadFiles = 'upload-files';
  // ---------------------- Player home -----------------------------------
  static const String home = 'home';
  static const String sports = 'sports';
  static const String stadiums = 'stadiums';
  static String stadiumDetails(int stadiumId) => 'stadiums/$stadiumId';
  static String stadiumSlots(int stadiumId) => 'stadiums/$stadiumId/slots';
  static const String bookings = 'bookings';
  static const String orders = 'orders';
  static const String deliveryOrders = 'deliveries/orders';
  static String orderDetails(int orderId) => 'orders/$orderId';
  static const String bookingCancelReasons = 'booking-cancel-reasons';
  static const String bookingOpponents = 'bookings/opponents';
  static String bookingDetails(int bookingId) => 'bookings/$bookingId';
  static String cancelBooking(int bookingId) => 'bookings/$bookingId/cancel';
  static String reviewBooking(int bookingId) => 'bookings/$bookingId/review';
  static String payBookingPlayer(int playerId) =>
      'bookings/players/$playerId/pay';
  static String respondToBookingMatch(int matchId) =>
      'bookings/matches/$matchId/respond';
  static const String teams = 'teams';
  static const String myTeam = 'teams/my';
  static String teamDetails(int teamId) => 'teams/$teamId';
  static String teamMembers(int teamId) => 'teams/$teamId/members';
  static String teamRequests(int teamId) => 'teams/my/requests';
  static String substituteTeamMember(int teamId) => 'teams/$teamId/substitute';
  static String acceptTeamRequest(int requestId) =>
      'requests/$requestId/accept';
  static String rejectTeamRequest(int requestId) =>
      'requests/$requestId/reject';
  // ---------------------- Auth -----------------------------------
  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String verifyOtp = 'auth/otp/verify';
  static const String resendOtp = 'auth/otp/resend';
  static const String cities = 'cities';
  static String districts(int cityId) => 'cities/$cityId/districts';
  static const String registerContent = 'user/get-register-data';
  static const String verifyAccountResendCode =
      'user/auth/verify-account-resend-code';
  static const String forgotPassword = 'auth/forgot-password';
  static const String resetPassword = 'auth/reset-password';

  // ---------------------- Notifications -----------------------------------
  static const String notifications = 'notifications';
  static const String unReadNotifications = 'user/notifications/count-unread';
  static const String deleteNotification = 'user/notifications/delete/';
  static const String deleteAllNotifications = 'user/notifications/delete-all';

  // ---------------------- Wallet -----------------------------------
  static const String wallet = 'wallet';
  static const String chargeWallet = 'wallet/topup';

  // ---------------------- Settings -----------------------------------
  static const String switchNotification = 'profile/notifications';
  static const String updateProfile = 'profile';
  static const String changePhoneCurrentSend = 'profile/phone/current/send';
  static const String changePhoneCurrentVerify = 'profile/phone/current/verify';
  static const String changePhoneCurrentResend = 'profile/phone/current/resend';
  static const String changePhoneNewSend = 'profile/phone/new/send';
  static const String changePhoneNewVerify = 'profile/phone/new/verify';
  static const String changePhoneNewResend = 'profile/phone/new/resend';
  static const String changePassword = 'profile/change-password';
  static const String changeLang = 'user/change-lang';
  static const String deleteAccount = 'user/delete-account';
  static const String updateCountry = 'user/profile/change-currency-country';
  // ---------------------- Change_Email -----------------------------------
  static const String changeEmailCheckPassword =
      'user/profile/change-email-check-password';
  static const String changeEmailSendCode =
      'user/profile/change-email-send-code';
  static const String changeEmailReSendCode =
      'user/profile/change-email-resend-code';
  static const String changeEmailVerifyCode =
      'user/profile/change-email-verify-code';

  // ---------------------- More -----------------------------------
  static const String faqs = 'get-faqs';
  static const String about = 'pages/about';
  static const String terms = 'pages/terms';
  static const String privacy = 'pages/privacy';
  static const String contactUs = 'contact';
  static const String complain = 'user/complaints/get-complaint-data';
  static const String addComplain = 'user/complaints/send';
  static const String complainDetails = 'user/complaints/';
  static const String logOut = 'auth/logout';
  static const String employees = 'customers';
  static String employeeDetails(int employeeId) => 'customers/$employeeId';
}
