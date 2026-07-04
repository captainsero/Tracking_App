import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/order_details/data/models/order_dto.dart';

abstract interface class OrderDetailsDataSourceContract {
  Future<BaseResponse<OrderDto>> startOrder(String orderId);
}
