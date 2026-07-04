import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/order_details/domain/entitty/order_entity.dart';
import 'package:tracking_app/features/order_details/domain/repo/order_details_repo_contract.dart';

@injectable
class StartOrderUseCase {
  final OrderDetailsRepoContract orderDetailsRepoContract;
  StartOrderUseCase(this.orderDetailsRepoContract);

  Future<BaseResponse<OrderEntity>> call(String orderId) async {
    return await orderDetailsRepoContract.startOrder(orderId);
  }
}
