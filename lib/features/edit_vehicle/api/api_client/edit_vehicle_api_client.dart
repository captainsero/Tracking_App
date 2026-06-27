import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tracking_app/core/constants/api_constants/api_endpoints.dart';
import 'package:tracking_app/features/edit_vehicle/data/models/edit_vehicle_request_model.dart';
import 'package:tracking_app/features/edit_vehicle/data/models/edit_vehicle_response_model.dart';

part 'edit_vehicle_api_client.g.dart';

@RestApi()
@lazySingleton
abstract class EditVehicleApiClient {
  @factoryMethod
  factory EditVehicleApiClient(Dio dio) = _EditVehicleApiClient;

  @PUT(ApiEndpoints.editVehicleInfo)
  Future<EditVehicleResponseModel> editVehicle(@Body() EditVehicleRequestModel request);
}