import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_response_model.g.dart';

@JsonSerializable()
class ForgotPasswordResponseModel {
  final String? message;
  final String? status;
  final int? code;
  final String? info;
  final String? token;

  ForgotPasswordResponseModel({
    this.message,
    this.code,
    this.info,
    this.token,
    this.status,
  });

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseModelToJson(this);
}
