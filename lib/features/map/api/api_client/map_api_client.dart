import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tracking_app/core/constants/api_constants/api_endpoints.dart';
import 'package:tracking_app/core/constants/api_constants/base_urls.dart';
import 'package:tracking_app/core/constants/app_keys/api_keys.dart';
import 'package:tracking_app/features/map/data/models/map_path_response_model.dart';

part 'map_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: BaseUrls.osrmBaseUrl)
abstract class MapApiClient {
  @factoryMethod
  factory MapApiClient(Dio dio) = _MapApiClient;

  @GET(ApiEndpoints.getRouteCoordinates)
  Future<MapPathResponseModel> getRoutePoints(
    @Path(ApiKeys.coordinates) String coordinates, {
    @Query(ApiKeys.overview) String overview = 'full',
    @Query(ApiKeys.geometries) String geometries = 'geojson',
  });
}
