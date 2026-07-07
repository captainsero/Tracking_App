import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_request_model.g.dart';

@JsonSerializable(includeIfNull: false)
class EditProfileRequestModel {
  final String? firstName;
  final String? lastName;
  final String? phone;
  // Excluded from JSON serialization because the backend API (/drivers/editProfile)
  // Joi schema does not accept the "gender" field and throws a "gender is not allowed" error.
  @JsonKey(includeToJson: false)
  final String? gender;


  EditProfileRequestModel({
    this.firstName,
    this.lastName,
    this.phone,
    this.gender,
  });

  factory EditProfileRequestModel.fromJson(Map<String, dynamic> json) =>
      _$EditProfileRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileRequestModelToJson(this);
}
