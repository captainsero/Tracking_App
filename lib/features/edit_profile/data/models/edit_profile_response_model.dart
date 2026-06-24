import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_response_model.g.dart';

@JsonSerializable()
class EditProfileResponseModel {
  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'driver')
  final DriverModel driver;

  EditProfileResponseModel({required this.message, required this.driver});

  factory EditProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EditProfileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileResponseModelToJson(this);
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
