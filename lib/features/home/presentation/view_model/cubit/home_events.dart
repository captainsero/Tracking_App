import 'dart:async';

sealed class HomeEvents {}

class GetPendingOrdersEvent extends HomeEvents {
  final bool refresh;
  final Completer<void>? completer;

  GetPendingOrdersEvent({this.refresh = false, this.completer});
}

class RejectOrderEvent extends HomeEvents {
  final String orderId;

  RejectOrderEvent({required this.orderId});
}
