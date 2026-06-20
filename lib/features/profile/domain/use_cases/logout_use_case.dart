import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/profile/domain/repo/profile_repo_contract.dart';

@injectable
class LogoutUseCase {
  final ProfileRepoContract profileRepoContract;

  LogoutUseCase({required this.profileRepoContract});

  Future<BaseResponse<String>> call() {
    return profileRepoContract.logout();
  }
}
