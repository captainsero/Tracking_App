sealed class HomeEvents {}

class GetPendingOrdersEvent extends HomeEvents {
  final bool refresh;

  GetPendingOrdersEvent({this.refresh = false});
}

class RejectOrderEvent extends HomeEvents {
  final String orderId;

  RejectOrderEvent({required this.orderId});
}
