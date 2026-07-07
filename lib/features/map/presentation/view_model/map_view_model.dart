import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/config/launcher_service/launcher_service.dart';
import 'package:tracking_app/config/map_service/location_service.dart';
import 'package:tracking_app/core/errors/app_error_localizer.dart';
import 'package:tracking_app/features/map/data/models/map_path_model.dart';
import 'package:tracking_app/features/map/domain/use_cases/get_route_points_use_case.dart';
import 'package:tracking_app/generated/l10n.dart';
import 'map_event.dart';
import 'map_state.dart';

@injectable
class MapCubit extends Cubit<MapState> {
  final GetRoutePointsUseCase _getRoutePointsUseCase;
  final LocationService _locationService;
  final LauncherService _launcherService;

  Timer? _locationTimer;

  MapCubit({
    required GetRoutePointsUseCase getRoutePointsUseCase,
    required LocationService locationService,
    required LauncherService launcherService,
  }) : _launcherService = launcherService,
       _getRoutePointsUseCase = getRoutePointsUseCase,
       _locationService = locationService,
       super(const MapState());

  void onEvent(MapEvents event) {
    switch (event) {
      case GetRouteEvent():
        _getRouteAndStartTracking(event.endPoint);
      case CallUserEvent():
        _callUser(event.phone);
      case OpenChatEvent():
        _openChat(event.phone);
    }
  }

  Future<void> _getRouteAndStartTracking(LatLng end) async {
    emit(state.copyWith(getRouteState: const BaseState(isLoading: true)));

    final locationResponse = await _locationService.getCurrentLocation();
    if (isClosed) return;

    final LatLng start;
    switch (locationResponse) {
      case SuccessBaseResponse<LatLng>():
        start = locationResponse.data;
      case ErrorBaseResponse<LatLng>():
        emit(
          state.copyWith(
            getRouteState: BaseState(
              isLoading: false,
              errorMessage: locationResponse.error.toString(),
            ),
          ),
        );
        return;
    }

    final String coords =
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final response = await _getRoutePointsUseCase(coordinates: coords);
    if (isClosed) return;

    switch (response) {
      case SuccessBaseResponse<List<MapPathModel>>():
        List<LatLng> roadPoints = [start, end];

        if (response.data.isNotEmpty) {
          final path = response.data.first;
          if (path.geometry?.coordinates != null) {
            roadPoints = path.geometry!.coordinates!.map((coord) {
              final double lat = (coord[1] as num).toDouble();
              final double lng = (coord[0] as num).toDouble();
              return LatLng(lat, lng);
            }).toList();
          }
        }

        emit(
          state.copyWith(
            getRouteState: BaseState(isLoading: false, data: roadPoints),
            currentDeliveryLocation: start,
          ),
        );

      _startLiveTracking(end);

      case ErrorBaseResponse<List<MapPathModel>>():
        emit(
          state.copyWith(
            getRouteState: BaseState(
              isLoading: false,
              errorMessage: response.appError.localize(S.current),
            ),
          ),
        );
    }
  }

  void _startLiveTracking(LatLng end) {
    _locationTimer?.cancel();

    _locationTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final locationResponse = await _locationService.getCurrentLocation();
      if (isClosed) return;

      if (locationResponse is! SuccessBaseResponse<LatLng>) {
        return;
      }

      final LatLng newLocation = locationResponse.data;
      final String coords =
          '${newLocation.longitude},${newLocation.latitude};${end.longitude},${end.latitude}';
      final response = await _getRoutePointsUseCase(coordinates: coords);
      if (isClosed) return;

      List<LatLng> updatedRoadPoints = [newLocation, end];

      switch (response) {
        case SuccessBaseResponse<List<MapPathModel>>():
          if (response.data.isNotEmpty) {
            final path = response.data.first;
            if (path.geometry?.coordinates != null) {
              updatedRoadPoints = path.geometry!.coordinates!.map((coord) {
                final double lat = (coord[1] as num).toDouble();
                final double lng = (coord[0] as num).toDouble();
                return LatLng(lat, lng);
              }).toList();
            }
          }

          emit(
            state.copyWith(
              currentDeliveryLocation: newLocation,
              getRouteState: BaseState(data: updatedRoadPoints),
            ),
          );
        case ErrorBaseResponse<List<MapPathModel>>():
          emit(state.copyWith(currentDeliveryLocation: newLocation));
      }
    });
  }

  Future<void> _callUser(String phone) async {
    await _launcherService.openPhone(phone);
  }

  Future<void> _openChat(String phone) async {
    await _launcherService.openWhatsApp(phone);
  }

  @override
  Future<void> close() {
    _locationTimer?.cancel();
    return super.close();
  }
}
