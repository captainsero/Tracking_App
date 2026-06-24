import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request_model.g.dart';

@JsonSerializable(includeIfNull: false)
class EditProfileRequestModel {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? country;
  final String? gender;
  final String? vehicleType;
  final String? vehicleNumber;
  final String? vehicleLicense;
  final String? nid;
  final String? nidImg;

  EditProfileRequestModel({
    this.firstName,
    this.lastName,
    this.phone,
    this.country,
    this.gender,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
    this.nid,
    this.nidImg,
  });

  factory EditProfileRequestModel.fromJson(Map<String, dynamic> json) =>
      _$EditProfileRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileRequestModelToJson(this);
}
