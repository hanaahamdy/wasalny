class ApiConstants {
 // new
  static const String login = 'auth/login';



  // ---------------------- Notifications -----------------------------------
  static const String notifications = 'notifications';
  static const String unReadNotifications = 'user/notifications/count-unread';
  static const String deleteNotification = 'user/notifications/delete/';
  static const String deleteAllNotifications = 'user/notifications/delete-all';



  // ---------------------- Settings -----------------------------------
  static const String switchNotification = 'profile/notifications';
  static const String updateProfile = 'profile';
  static const String profile = 'profile';
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
}
