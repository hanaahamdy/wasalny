import '../../../../../../../config/language/locale_keys.g.dart';

enum AdminOrderTab {
  pending,
  onHolding,
  created,
  delivering,
  received,
  cancelled;

  String get label => switch (this) {
    AdminOrderTab.pending => LocaleKeys.orderPending,
    AdminOrderTab.onHolding => LocaleKeys.orderOnHolding,
    AdminOrderTab.created => LocaleKeys.orderCreated,
    AdminOrderTab.delivering => LocaleKeys.orderDelivering,
    AdminOrderTab.received => LocaleKeys.orderReceived,
    AdminOrderTab.cancelled => LocaleKeys.orderCancelled,
  };
}

enum DeliveryOrderTab {
  created,
  received,
  delivering,
  delivered;

  String get label => switch (this) {
    DeliveryOrderTab.created => LocaleKeys.orderCreated,
    DeliveryOrderTab.received => LocaleKeys.orderReceived,
    DeliveryOrderTab.delivering => LocaleKeys.orderDelivering,
    DeliveryOrderTab.delivered => LocaleKeys.delivered,
  };

  String get apiValue => switch (this) {
    DeliveryOrderTab.created => 'created',
    DeliveryOrderTab.received => 'received',
    DeliveryOrderTab.delivering => 'in_delivery',
    DeliveryOrderTab.delivered => 'delivered',
  };
}

//pending , created  , in_delivery ,delivered ,cancelled ,on_hold ,received
