import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/profile/domain/entities/profile_data_entity.dart';

abstract class ProfileRepoContract {
  Future<BaseResponse<String>> logout();
  Future<BaseResponse<ProfileDataEntity>> getProfileData();
}
