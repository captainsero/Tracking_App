import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tracking_app/core/constants/api_constants/api_endpoints.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/requests/forgot_password_request.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/requests/reset_password_request.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/responses/forgot_password_response_model.dart';
part 'forgot_password_api_client.g.dart';

@RestApi()
@lazySingleton
abstract class ForgotPasswordApiClient {
  @FactoryMethod()
  factory ForgotPasswordApiClient(Dio dio) = _ForgotPasswordApiClient;

  @POST(ApiEndpoints.forgotPassword)
  Future<ForgotPasswordResponseModel?> forgotPassword(
    @Body() ForgotPasswordRequest forgotPasswordRequest,
  );

  @POST(ApiEndpoints.verifyReset)
  Future<ForgotPasswordResponseModel?> verifyReset({
    @BodyExtra('resetCode') required String resetCode,
  });

  @PUT(ApiEndpoints.resetPassword)
  Future<ForgotPasswordResponseModel?> resetPassword({
    @Body() required Map<String, dynamic> resetPasswordRequest,
  });
}
