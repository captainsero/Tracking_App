import 'package:latlong2/latlong.dart';

sealed class MapEvents {}

class GetRouteEvent extends MapEvents {
  final LatLng endPoint;

  GetRouteEvent({required this.endPoint});
}

class CallUserEvent extends MapEvents {
  final String phone;

  CallUserEvent({required this.phone});
}

class OpenChatEvent extends MapEvents {
  final String phone;

  OpenChatEvent({required this.phone});
}
