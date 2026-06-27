import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/profile/domain/repo/profile_repo_contract.dart';
import '../entities/profile_data_entity.dart';

@Injectable()
class GetProfileDataUseCase {
  final ProfileRepoContract repository;

  GetProfileDataUseCase({required this.repository});

  Future<BaseResponse<ProfileDataEntity>> call() async {
    return await repository.getProfileData();
  }
}
