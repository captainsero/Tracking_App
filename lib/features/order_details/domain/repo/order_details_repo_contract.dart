import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/order_details/domain/entitty/order_entity.dart';
import 'package:tracking_app/features/order_details/domain/entitty/order_status.dart';

abstract interface class OrderDetailsRepoContract {
  Future<BaseResponse<OrderEntity>> startOrder(String orderId);

  Future<void> updateStatus(
    String orderId,
    OrderStatus status, {
    String? driverName,
    String? driverPhone,
  });
}
