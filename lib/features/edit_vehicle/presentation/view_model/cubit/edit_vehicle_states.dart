import 'package:equatable/equatable.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/features/edit_vehicle/domain/entities/edit_vehicle_response_entity.dart';

class EditVehicleStates extends Equatable {
  const EditVehicleStates({
    this.updateVehicleState = const BaseState<EditVehicleResponseEntity>(),
  });

  /// State for the save/update operation.
  final BaseState<EditVehicleResponseEntity> updateVehicleState;

  EditVehicleStates copyWith({
    BaseState<EditVehicleResponseEntity>? updateVehicleState,
  }) {
    return EditVehicleStates(
      updateVehicleState: updateVehicleState ?? this.updateVehicleState,
    );
  }

  @override
  List<Object?> get props => [updateVehicleState];
}
