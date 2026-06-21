import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/home/data/models/get_orders_response.dart';

abstract class HomeRemoteDataSourceContract {
  Future<BaseResponse<GetOrdersResponse>> getPendingOrders();
}
