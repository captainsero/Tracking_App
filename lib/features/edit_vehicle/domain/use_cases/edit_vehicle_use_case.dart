import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/edit_vehicle/domain/entities/edit_vehicle_request_entity.dart';
import 'package:tracking_app/features/edit_vehicle/domain/entities/edit_vehicle_response_entity.dart';
import 'package:tracking_app/features/edit_vehicle/domain/repositories/edit_vehicle_repository.dart';

@lazySingleton
class EditVehicleUseCase {
  final EditVehicleRepository repository;

  EditVehicleUseCase({required this.repository});

  Future<BaseResponse<EditVehicleResponseEntity>> call({
    required EditVehicleRequestEntity entity,
  }) async {
    return await repository.editVehicle(entity: entity);
  }
}