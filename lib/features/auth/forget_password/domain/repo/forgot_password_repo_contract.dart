import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/requests/forgot_password_request.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/requests/reset_password_request.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/responses/forgot_password_response_model.dart';

abstract interface class ForgotPasswordRepoContract {
  Future<BaseResponse<ForgotPasswordResponseModel?>> forgotPassword(
    ForgotPasswordRequest email,
  );

  Future<BaseResponse<ForgotPasswordResponseModel?>> verifyReset(
    String resetCode,
  );

  Future<BaseResponse<ForgotPasswordResponseModel?>> resetPassword(
    ResetPasswordRequest body,
  );
}
