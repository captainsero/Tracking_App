import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tracking_app/core/constants/api_constants/api_endpoints.dart';
import 'package:tracking_app/features/auth/login/data/models/login_request_model.dart';
import 'package:tracking_app/features/auth/login/data/models/login_response_model.dart';

part 'login_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: ApiEndpoints.login)
abstract class LoginApiClient {
  @factoryMethod
  factory LoginApiClient(Dio dio) = _LoginApiClient;

  @POST(ApiEndpoints.login)
  Future<LoginResponseModel> login(@Body() LoginRequestModel request);
}
