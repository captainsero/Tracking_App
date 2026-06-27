import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/home/domain/entities/order_entity.dart';

abstract class HomeRepoContract {
  Future<BaseResponse<List<OrderEntity>>> getPendingOrders({required int page});
}
