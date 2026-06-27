import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/config/handler/response_to_state_mapper.dart';
import 'package:tracking_app/features/edit_vehicle/domain/entities/edit_vehicle_request_entity.dart';
import 'package:tracking_app/features/edit_vehicle/domain/entities/edit_vehicle_response_entity.dart';
import 'package:tracking_app/features/edit_vehicle/domain/use_cases/edit_vehicle_use_case.dart';

import 'edit_vehicle_events.dart';
import 'edit_vehicle_states.dart';

@injectable
class EditVehicleCubit extends Cubit<EditVehicleStates> {
  EditVehicleCubit(this._editVehicleUseCase) : super(const EditVehicleStates());

  final EditVehicleUseCase _editVehicleUseCase;

  static const Map<String, String> _vehicleTypeMap = {
    'Car': '507f1f77bcf86cd799439011',
    'Motorcycle': '507f1f77bcf86cd799439012',
    'Bicycle': '507f1f77bcf86cd799439013',
    'Truck': '507f1f77bcf86cd799439014',
  };

  static const Map<String, String> _vehicleIdToNameMap = {
    '507f1f77bcf86cd799439011': 'Car',
    '507f1f77bcf86cd799439012': 'Motorcycle',
    '507f1f77bcf86cd799439013': 'Bicycle',
    '507f1f77bcf86cd799439014': 'Truck',
  };

  final vehicleTypeController = TextEditingController();
  final vehicleNumberController = TextEditingController();
  final vehicleLicenseController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  /// Pre-populate fields with current vehicle data coming from the profile screen.
  void initFields({
    required String vehicleType,
    required String vehicleNumber,
    required String vehicleLicense,
  }) {
    final displayType = _vehicleIdToNameMap[vehicleType] ??
        (_vehicleTypeMap.containsKey(vehicleType) ? vehicleType : 'Car');
    vehicleTypeController.text = displayType;
    vehicleNumberController.text = vehicleNumber;
    vehicleLicenseController.text = vehicleLicense;
  }

  void doIntent(EditVehicleEvents event) {
    event.when(updateVehicleEvent: _updateVehicle);
  }

  Future<void> _updateVehicle() async {
    final vehicleType = vehicleTypeController.text.trim();
    final vehicleNumber = vehicleNumberController.text.trim();
    final vehicleLicense = vehicleLicenseController.text.trim();

    // At least one field must have a value.
    if (vehicleType.isEmpty &&
        vehicleNumber.isEmpty &&
        vehicleLicense.isEmpty) {
      return;
    }

    emit(
      state.copyWith(
        updateVehicleState: const BaseState<EditVehicleResponseEntity>(
          isLoading: true,
        ),
      ),
    );

    final mappedType = _vehicleTypeMap[vehicleType] ?? vehicleType;

    final entity = EditVehicleRequestEntity(
      vehicleType: mappedType.isEmpty ? null : mappedType,
      vehicleNumber: vehicleNumber.isEmpty ? null : vehicleNumber,
      vehicleLicense: vehicleLicense.isEmpty ? null : vehicleLicense,
    );

    final result = await _editVehicleUseCase.call(entity: entity);

    emit(
      state.copyWith(
        updateVehicleState: ResponseToStateMapper.handle(result),
      ),
    );
  }

  @override
  Future<void> close() {
    if (isClosed) return super.close();
    vehicleTypeController.dispose();
    vehicleNumberController.dispose();
    vehicleLicenseController.dispose();
    return super.close();
  }
}
