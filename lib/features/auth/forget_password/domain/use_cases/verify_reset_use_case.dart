import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/responses/forgot_password_response_model.dart';
import 'package:tracking_app/features/auth/forget_password/domain/repo/forgot_password_repo_contract.dart';

@injectable
class VerifyResetUseCase {
  final ForgotPasswordRepoContract repo;

  VerifyResetUseCase({required this.repo});
  Future<BaseResponse<ForgotPasswordResponseModel?>> call(
    String resetCode,
  ) async {
    return await repo.verifyReset(resetCode);
  }
}
