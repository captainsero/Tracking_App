import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/map/data/models/map_path_response_model.dart';
import 'package:tracking_app/features/map/api/api_client/map_api_client.dart';
import 'package:tracking_app/features/map/data/data_sources/map_remote_data_source_contract.dart';

@Injectable(as: MapRemoteDataSourceContract)
class MapRemoteDataSourceImp implements MapRemoteDataSourceContract {
  final MapApiClient _apiClient;

  MapRemoteDataSourceImp({required MapApiClient apiClient})
    : _apiClient = apiClient;
  @override
  Future<BaseResponse<MapPathResponseModel>> getRoutePoints({
    required String coordinates,
  }) async {
    try {
      final response = await _apiClient.getRoutePoints(coordinates);
      return SuccessBaseResponse(data: response);
    } catch (error) {
      return ErrorBaseResponse(error: error);
    }
  }
}
