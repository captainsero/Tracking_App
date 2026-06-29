import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/shared_models/map_models/map_path_response_model.dart';

part 'route_map_service.g.dart';

@RestApi(baseUrl: 'https://router.project-osrm.org/')
abstract class _RouteMapApiClient {
  factory _RouteMapApiClient(Dio dio) = __RouteMapApiClient;

  @GET('route/v1/driving/{coordinates}')
  Future<MapPathResponseModel> getRoutePoints(
    @Path('coordinates') String coordinates, {
    @Query('overview') String overview = 'full',
    @Query('geometries') String geometries = 'geojson',
  });
}

@lazySingleton
class RouteMapService {
  late final _RouteMapApiClient _apiClient;

  RouteMapService(Dio dio) {
    _apiClient = _RouteMapApiClient(dio);
  }

  Future<BaseResponse<MapPathResponseModel>> getRoutePoints(
    String coordinates,
  ) async {
    try {
      final response = await _apiClient.getRoutePoints(coordinates);
      return SuccessBaseResponse(data: response);
    } catch (error) {
      return ErrorBaseResponse(error: error);
    }
  }
}
