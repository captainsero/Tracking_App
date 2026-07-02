import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking_app/config/base_state/base_state.dart';

class MapState extends Equatable {
  final BaseState<List<LatLng>> getRouteState;
  final LatLng? currentDeliveryLocation;

  const MapState({
    this.getRouteState = const BaseState<List<LatLng>>(isLoading: false),
    this.currentDeliveryLocation,
  });

  MapState copyWith({
    BaseState<List<LatLng>>? getRouteState,
    LatLng? currentDeliveryLocation,
  }) {
    return MapState(
      getRouteState: getRouteState ?? this.getRouteState,
      currentDeliveryLocation:
          currentDeliveryLocation ?? this.currentDeliveryLocation,
    );
  }

  @override
  List<Object?> get props => [getRouteState, currentDeliveryLocation];
}
