import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/change_password/data/models/change_password_request.dart';
import 'package:tracking_app/features/change_password/data/models/change_password_response.dart';
import 'package:tracking_app/features/change_password/domain/repo/change_password_repo.dart';

@injectable
class ChangePasswordUseCase {
  final ChangePasswordRepo _repo;

  const ChangePasswordUseCase(this._repo);

  Future<BaseResponse<ChangePasswordResponse>> call({
    required ChangePasswordRequest passwords,
  }) {
    return _repo.changePassword(passwords: passwords);
  }
}
