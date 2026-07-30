import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/auth/forget_password/api/api_client/forgot_password_api_client.dart';
import 'package:tracking_app/features/auth/forget_password/data/data_source/forgot_password_remote_data_source_contract.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/requests/forgot_password_request.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/requests/reset_password_request.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/responses/forgot_password_response_model.dart';

@Injectable(as: ForgotPasswordRemoteDataSourceContract)
class ForgotPasswordRemoteDataSourceImpl
    implements ForgotPasswordRemoteDataSourceContract {
  final ForgotPasswordApiClient apiClient;

  ForgotPasswordRemoteDataSourceImpl({required this.apiClient});
  @override
  Future<BaseResponse<ForgotPasswordResponseModel?>> forgotPassword(
    ForgotPasswordRequest email,
  ) async {
    try {
      final response = await apiClient.forgotPassword(email);
      return SuccessBaseResponse(
        data: response ?? ForgotPasswordResponseModel(),
      );
    } catch (e) {
      return ErrorBaseResponse(errorMessage: e.toString());
    }
  }

  @override
  Future<BaseResponse<ForgotPasswordResponseModel?>> resetPassword(
    ResetPasswordRequest resetPasswordRequest,
  ) async {
    try {
      final response = await apiClient.resetPassword(
        resetPasswordRequest: resetPasswordRequest.toJson(),
      );
      return SuccessBaseResponse(
        data: response ?? ForgotPasswordResponseModel(),
      );
    } catch (e) {
      return ErrorBaseResponse(errorMessage: e.toString());
    }
  }

  @override
  Future<BaseResponse<ForgotPasswordResponseModel?>> verifyReset(
    String resetCode,
  ) async {
    try {
      final response = await apiClient.verifyReset(resetCode: resetCode);
      return SuccessBaseResponse(
        data: response ?? ForgotPasswordResponseModel(),
      );
    } catch (e) {
      return ErrorBaseResponse(errorMessage: e.toString());
    }
  }
}
