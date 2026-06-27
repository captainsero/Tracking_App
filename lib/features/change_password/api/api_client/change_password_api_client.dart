import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tracking_app/core/constants/api_constants/api_endpoints.dart';
import 'package:tracking_app/features/change_password/data/models/change_password_request.dart';
import 'package:tracking_app/features/change_password/data/models/change_password_response.dart';

part 'change_password_api_client.g.dart';

@RestApi(baseUrl: ApiEndpoints.changePassword)
@lazySingleton
abstract class ChangePasswordApiClient {
  @factoryMethod
  factory ChangePasswordApiClient(Dio dio) = _ChangePasswordApiClient;

  @PATCH(ApiEndpoints.changePassword)
  Future<ChangePasswordResponse> changePassword({
    @Body() required ChangePasswordRequest body,
  });
}
