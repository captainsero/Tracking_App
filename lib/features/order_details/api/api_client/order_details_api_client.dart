import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tracking_app/core/constants/api_constants/api_endpoints.dart';
import 'package:tracking_app/features/order_details/data/models/order_details_response_model.dart';
part 'order_details_api_client.g.dart';

@RestApi()
@lazySingleton
abstract class OrderDetailsApiClient {
  @factoryMethod
  factory OrderDetailsApiClient(Dio dio) = _OrderDetailsApiClient;

  @GET(ApiEndpoints.orderDetails)
  Future<OrderDetailsResponseModel> startOrder({
    @Path("id") required String orderId,
  });
}
