import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tracking_app/core/constants/api_constants/api_endpoints.dart';
import 'package:tracking_app/core/constants/app_keys/api_keys.dart';
import 'package:tracking_app/features/home/data/models/get_orders_response.dart';

part 'home_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class HomeApiClient {
  @factoryMethod
  factory HomeApiClient(Dio dio) = _HomeApiClient;

  @GET(ApiEndpoints.pendingOrders)
  Future<GetOrdersResponse> getPendingOrders({
    @Query(ApiKeys.page) required int page,
  });
}
