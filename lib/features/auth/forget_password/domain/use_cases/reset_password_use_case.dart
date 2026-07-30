import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/requests/reset_password_request.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/responses/forgot_password_response_model.dart';
import 'package:tracking_app/features/auth/forget_password/domain/repo/forgot_password_repo_contract.dart';

@injectable
class ResetPasswordUseCase {
  final ForgotPasswordRepoContract repo;

  ResetPasswordUseCase({required this.repo});
  Future<BaseResponse<ForgotPasswordResponseModel?>> call(
    ResetPasswordRequest body,
  ) async {
    return await repo.resetPassword(body);
  }
}
