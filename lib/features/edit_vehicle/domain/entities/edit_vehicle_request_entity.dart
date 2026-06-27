import 'package:equatable/equatable.dart';

class EditVehicleRequestEntity extends Equatable {
  final String? vehicleType;
  final String? vehicleNumber;
  final String? vehicleLicense;

  const EditVehicleRequestEntity({
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
  });

  @override
  List<Object?> get props => [vehicleType, vehicleNumber, vehicleLicense];
}
