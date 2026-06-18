import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import 'package:tracking_app/core/constants/api_constants/api_endpoints.dart';

part "sign_up_api_client.g.dart";

@RestApi()
@singleton
abstract class SignUpApiClient {
  @factoryMethod
  factory SignUpApiClient(Dio dio) = _SignUpApiClient;

  @MultiPart()
  @POST(ApiEndpoints.signUp)
  Future<HttpResponse<dynamic>> signUp(
      @Part(name: 'country') String country,
      @Part(name: 'firstName') String firstName,
      @Part(name: 'lastName') String lastName,
      @Part(name: 'vehicleType') String vehicleType,
      @Part(name: 'vehicleNumber') String vehicleNumber,
      @Part(name: 'email') String email,
      @Part(name: 'phone') String phone,
      @Part(name: 'NID') String nid,
      @Part(name: 'password') String password,
      @Part(name: 'rePassword') String rePassword,
      @Part(name: 'gender') String gender,
      @Part(name: 'vehicleLicense') MultipartFile vehicleLicense,
      @Part(name: 'NIDImg') MultipartFile nidImage,
      );
}