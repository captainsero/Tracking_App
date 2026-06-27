import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/profile/data/models/profile_data_model.dart';

abstract class ProfileRemoteDataSourceContract {
  Future<BaseResponse<ProfileDataModel>> getProfileData();
  Future<BaseResponse<String>> logout();
}
