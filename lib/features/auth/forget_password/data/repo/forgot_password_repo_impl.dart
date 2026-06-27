import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/handler/secure_storage_handler.dart';
import 'package:tracking_app/config/secure_storage/secure_storage_service.dart';
import 'package:tracking_app/core/constants/app_keys/secure_storage_keys.dart';
import 'package:tracking_app/features/auth/forget_password/data/data_source/forgot_password_remote_data_source_contract.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/requests/forgot_password_request.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/requests/reset_password_request.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/responses/forgot_password_response_model.dart';
import 'package:tracking_app/features/auth/forget_password/domain/repo/forgot_password_repo_contract.dart';

@Injectable(as: ForgotPasswordRepoContract)
class ForgotPasswordRepoImpl implements ForgotPasswordRepoContract {
  final ForgotPasswordRemoteDataSourceContract
  forgotPasswordRemoteDataSourceContract;
  final SecureStorageService _secureStorageService;

  ForgotPasswordRepoImpl({
    required this.forgotPasswordRemoteDataSourceContract,
    required SecureStorageService secureStorageService,
  }) : _secureStorageService = secureStorageService;
  @override
  Future<BaseResponse<ForgotPasswordResponseModel?>> forgotPassword(
    ForgotPasswordRequest email,
  ) async {
    return await forgotPasswordRemoteDataSourceContract.forgotPassword(email);
  }

  @override
  Future<BaseResponse<ForgotPasswordResponseModel?>> resetPassword(
    ResetPasswordRequest body,
  ) async {
    final userEmail = await _secureStorageService.read(
      key: SecureStorageKeys.userEmail,
    );
    final handledEmail = SecureStorageHandler.handle(userEmail);

    body.email = handledEmail ?? "";

    return await forgotPasswordRemoteDataSourceContract.resetPassword(body);
  }

  @override
  Future<BaseResponse<ForgotPasswordResponseModel?>> verifyReset(
    String resetCode,
  ) async {
    return await forgotPasswordRemoteDataSourceContract.verifyReset(resetCode);
  }
}
