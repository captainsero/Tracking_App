import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/home/api/api_client/home_api_client.dart';
import 'package:tracking_app/features/home/data/data_sources/home_remote_data_source_contract.dart';
import 'package:tracking_app/features/home/data/models/get_orders_response.dart';

@Injectable(as: HomeRemoteDataSourceContract)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSourceContract {
  final HomeApiClient apiClient;

  HomeRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<BaseResponse<GetOrdersResponse>> getPendingOrders() async {
    try {
      final response = await apiClient.getPendingOrders();
      return SuccessBaseResponse<GetOrdersResponse>(data: response);
    } catch (e) {
      return ErrorBaseResponse<GetOrdersResponse>(error: e);
    }
  }
}
