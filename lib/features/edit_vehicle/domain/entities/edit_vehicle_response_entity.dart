import 'package:equatable/equatable.dart';
import 'package:tracking_app/features/edit_vehicle/data/models/edit_vehicle_response_model.dart';

class EditVehicleResponseEntity extends Equatable {
  final String message;
  final DriverEntity driver;

  const EditVehicleResponseEntity({
    required this.message,
    required this.driver,
  });

  @override
  List<Object?> get props => [message, driver];
}