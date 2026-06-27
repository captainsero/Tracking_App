import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/edit_vehicle/domain/entities/edit_vehicle_request_entity.dart';
import 'package:tracking_app/features/edit_vehicle/domain/entities/edit_vehicle_response_entity.dart';

abstract class EditVehicleRepository {
  Future<BaseResponse<EditVehicleResponseEntity>> editVehicle({
    required EditVehicleRequestEntity entity,
  });
}
