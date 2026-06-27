import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_vehicle_response_model.g.dart';

@JsonSerializable()
class EditVehicleResponseModel {
  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'driver')
  final DriverModel driver;

  EditVehicleResponseModel({required this.message, required this.driver});

  factory EditVehicleResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EditVehicleResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditVehicleResponseModelToJson(this);
}

@JsonSerializable()
class DriverModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'country')
  final String country;
  @JsonKey(name: 'firstName')
  final String firstName;
  @JsonKey(name: 'lastName')
  final String lastName;
  @JsonKey(name: 'vehicleType')
  final String vehicleType;
  @JsonKey(name: 'vehicleNumber')
  final String vehicleNumber;
  @JsonKey(name: 'vehicleLicense')
  final String vehicleLicense;
  @JsonKey(name: 'NID')
  final String nid;
  @JsonKey(name: 'NIDImg')
  final String nidImg;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'gender')
  final String gender;
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: 'photo')
  final String photo;
  @JsonKey(name: 'role')
  final String role;
  @JsonKey(name: 'createdAt')
  final String createdAt;

  DriverModel({
    required this.id,
    required this.country,
    required this.firstName,
    required this.lastName,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleLicense,
    required this.nid,
    required this.nidImg,
    required this.email,
    required this.password,
    required this.gender,
    required this.phone,
    required this.photo,
    required this.role,
    required this.createdAt,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) =>
      _$DriverModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverModelToJson(this);
}

// ---------------------------------------------------------------------------
// DriverEntity — lives here so the repository_impl can map model → entity
// without a separate mapper file.
// ---------------------------------------------------------------------------

class DriverEntity extends Equatable {
  final String id;
  final String country;
  final String firstName;
  final String lastName;
  final String vehicleType;
  final String vehicleNumber;
  final String vehicleLicense;
  final String nid;
  final String nidImg;
  final String email;
  final String password;
  final String gender;
  final String phone;
  final String photo;
  final String role;
  final String createdAt;

  const DriverEntity({
    required this.id,
    required this.country,
    required this.firstName,
    required this.lastName,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleLicense,
    required this.nid,
    required this.nidImg,
    required this.email,
    required this.password,
    required this.gender,
    required this.phone,
    required this.photo,
    required this.role,
    required this.createdAt,
  });

  /// Computed property for full name.
  String get fullName => '$firstName $lastName';

  @override
  List<Object?> get props => [
        id,
        country,
        firstName,
        lastName,
        vehicleType,
        vehicleNumber,
        vehicleLicense,
        nid,
        nidImg,
        email,
        password,
        gender,
        phone,
        photo,
        role,
        createdAt,
      ];
}

// ---------------------------------------------------------------------------
// Mapping extension: DriverModel → DriverEntity
// Absorbed from the deleted edit_profile_model_mapper.dart.
// ---------------------------------------------------------------------------

extension DriverModelMapper on DriverModel {
  DriverEntity toDriverEntity() {
    return DriverEntity(
      id: id,
      country: country,
      firstName: firstName,
      lastName: lastName,
      vehicleType: vehicleType,
      vehicleNumber: vehicleNumber,
      vehicleLicense: vehicleLicense,
      nid: nid,
      nidImg: nidImg,
      email: email,
      password: password,
      gender: gender,
      phone: phone,
      photo: photo,
      role: role,
      createdAt: createdAt,
    );
  }
}
