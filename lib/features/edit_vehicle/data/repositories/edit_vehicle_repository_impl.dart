import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/edit_vehicle/data/datasources/edit_vehicle_remote_data_source_contract.dart';
import 'package:tracking_app/features/edit_vehicle/data/models/edit_vehicle_request_model.dart';
import 'package:tracking_app/features/edit_vehicle/data/models/edit_vehicle_response_model.dart';
import 'package:tracking_app/features/edit_vehicle/domain/entities/edit_vehicle_request_entity.dart';
import 'package:tracking_app/features/edit_vehicle/domain/entities/edit_vehicle_response_entity.dart';
import 'package:tracking_app/features/edit_vehicle/domain/repositories/edit_vehicle_repository.dart';

@LazySingleton(as: EditVehicleRepository)
class EditProfileRepositoryImpl implements EditVehicleRepository {
  final EditVehicleRemoteDataSourceContract _remoteDataSource;

  EditProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<EditVehicleResponseEntity>> editVehicle({
    required EditVehicleRequestEntity entity,
  }) async {
    try {
      final request = EditVehicleRequestModel(
        vehicleType: entity.vehicleType,
        vehicleNumber: entity.vehicleNumber,
        vehicleLicense: entity.vehicleLicense,
      );

      final result = await _remoteDataSource.editVehicle(body: request);

      if (result is SuccessBaseResponse<EditVehicleResponseModel>) {
        return SuccessBaseResponse<EditVehicleResponseEntity>(
          data: EditVehicleResponseEntity(
            message: result.data.message,
            driver: result.data.driver.toDriverEntity(),
          ),
        );
      } else {
        final error = result as ErrorBaseResponse<EditVehicleResponseModel>;
        throw error.error ?? Exception(error.errorMessage);
      }
    } catch (e) {
      return ErrorBaseResponse<EditVehicleResponseEntity>(error: e);
    }
  }
}
