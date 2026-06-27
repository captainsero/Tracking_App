import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/edit_vehicle/api/api_client/edit_vehicle_api_client.dart';
import 'package:tracking_app/features/edit_vehicle/data/datasources/edit_vehicle_remote_data_source_contract.dart';
import 'package:tracking_app/features/edit_vehicle/data/models/edit_vehicle_request_model.dart';
import 'package:tracking_app/features/edit_vehicle/data/models/edit_vehicle_response_model.dart';

@LazySingleton(as: EditVehicleRemoteDataSourceContract)
class EditVehicleRemoteDataSourceImpl
    implements EditVehicleRemoteDataSourceContract {
  final EditVehicleApiClient _apiClient;

  EditVehicleRemoteDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<EditVehicleResponseModel>> editVehicle({
    required EditVehicleRequestModel body,
  }) async {
    try {
      final response = await _apiClient.editVehicle(body);
      return SuccessBaseResponse<EditVehicleResponseModel>(data: response);
    } catch (e) {
      return ErrorBaseResponse<EditVehicleResponseModel>(error: e);
    }
  }
}
