import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/order_details/api/api_client/order_details_api_client.dart';
import 'package:tracking_app/features/order_details/data/data_sources/order_details_data_source_contract.dart';
import 'package:tracking_app/features/order_details/data/models/order_dto.dart';

@Injectable(as: OrderDetailsDataSourceContract)
class OrderDetailsDataSourceImpl implements OrderDetailsDataSourceContract {
  final OrderDetailsApiClient orderDetailsApiClient;

  OrderDetailsDataSourceImpl({required this.orderDetailsApiClient});
  @override
  Future<BaseResponse<OrderDto>> startOrder(String orderId) async {
    try {
      final response = await orderDetailsApiClient.startOrder(orderId: orderId);

      return SuccessBaseResponse(data: response.orderDto);
    } catch (e) {
      return ErrorBaseResponse(error: e);
    }
  }
}
