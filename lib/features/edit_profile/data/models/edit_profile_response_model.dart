import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_response_model.g.dart';

@JsonSerializable()
class EditProfileResponseModel {
  final String message;
  final DriverModel driver;

  EditProfileResponseModel({
    required this.message,
    required this.driver,
  });

  factory EditProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EditProfileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileResponseModelToJson(this);
}

@JsonSerializable()
class DriverModel {
  @JsonKey(name: '_id')
  final String id;
  final String country;
  final String firstName;
  final String lastName;
  final String vehicleType;
  final String vehicleNumber;
  final String vehicleLicense;
  @JsonKey(name: 'NID')
  final String nid;
  @JsonKey(name: 'NIDImg')
  final String nidImg;
  final String email;
  final String password;
  final String gender;
  final String phone;
  final String photo;
  final String role;
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
