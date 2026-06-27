import 'package:json_annotation/json_annotation.dart';

part 'edit_vehicle_request_model.g.dart';

@JsonSerializable(includeIfNull: false)
class EditVehicleRequestModel {
  final String? vehicleType;
  final String? vehicleNumber;
  final String? vehicleLicense;

  EditVehicleRequestModel({
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
  });

  factory EditVehicleRequestModel.fromJson(Map<String, dynamic> json) =>
      _$EditVehicleRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditVehicleRequestModelToJson(this);
}
