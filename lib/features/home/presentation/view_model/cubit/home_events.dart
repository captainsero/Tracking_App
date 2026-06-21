sealed class HomeEvents {}

class GetPendingOrdersEvent extends HomeEvents {
  final bool refresh;

  GetPendingOrdersEvent({this.refresh = false});
}
