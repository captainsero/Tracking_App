import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/home/domain/entities/order_entity.dart';
import 'package:tracking_app/features/home/domain/repo/home_repo_contract.dart';

@injectable

class GetPendingOrdersUseCase {
  final HomeRepoContract repoContract;

  GetPendingOrdersUseCase({required this.repoContract});

  Future<BaseResponse<List<OrderEntity>>> call() {
    return repoContract.getPendingOrders();
  }
}
