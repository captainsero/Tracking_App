import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/home/data/data_sources/home_remote_data_source_contract.dart';
import 'package:tracking_app/features/home/data/models/get_orders_response.dart';
import 'package:tracking_app/features/home/domain/entities/order_entity.dart';
import 'package:tracking_app/features/home/domain/repo/home_repo_contract.dart';

@Injectable(as: HomeRepoContract)
class HomeRepoImpl implements HomeRepoContract {
  final HomeRemoteDataSourceContract homeRemoteDataSource;

  HomeRepoImpl({required this.homeRemoteDataSource});
  @override
  Future<BaseResponse<List<OrderEntity>>> getPendingOrders({
    required int page,
  }) async {
    final response = await homeRemoteDataSource.getPendingOrders(page: page);
    switch (response) {
      case SuccessBaseResponse<GetOrdersResponse>():
        return SuccessBaseResponse<List<OrderEntity>>(
          data: response.data.orders!
              .map((order) => order.toHomeDomain())
              .toList(),
        );
      case ErrorBaseResponse<GetOrdersResponse>():
        return ErrorBaseResponse<List<OrderEntity>>(error: response.error);
    }
  }
}
