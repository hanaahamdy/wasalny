import '../../../../../../../config/language/locale_keys.g.dart';

enum AdminOrderTab {
  pending,
  created,
  delivering,
  received,
  cancelled;

  String get label => switch (this) {
    AdminOrderTab.pending => LocaleKeys.orderPending,
    AdminOrderTab.created => LocaleKeys.orderCreated,
    AdminOrderTab.delivering => LocaleKeys.orderDelivering,
    AdminOrderTab.received => LocaleKeys.orderReceived,
    AdminOrderTab.cancelled => LocaleKeys.orderCancelled,
  };
}

enum DeliveryOrderTab {
  created,
  delivered,
  delivering,
  recieved;

  String get label => switch (this) {
    DeliveryOrderTab.created => LocaleKeys.orderCreated,
    DeliveryOrderTab.delivered => LocaleKeys.orderReceived,
    DeliveryOrderTab.delivering => LocaleKeys.orderDelivering,
    DeliveryOrderTab.recieved => LocaleKeys.delivered,
  };
}
