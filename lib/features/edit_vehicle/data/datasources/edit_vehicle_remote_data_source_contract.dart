import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/edit_vehicle/data/models/edit_vehicle_request_model.dart';
import 'package:tracking_app/features/edit_vehicle/data/models/edit_vehicle_response_model.dart';

abstract class EditVehicleRemoteDataSourceContract {
  Future<BaseResponse<EditVehicleResponseModel>> editVehicle({
    required EditVehicleRequestModel body,
  });
}