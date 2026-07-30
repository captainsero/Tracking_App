import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/profile/data/data_sources/profile_remote_data_source_contract.dart';
import 'package:tracking_app/features/profile/data/models/profile_data_model.dart';
import 'package:tracking_app/features/profile/domain/entities/profile_data_entity.dart';
import 'package:tracking_app/features/profile/domain/repo/profile_repo_contract.dart';

@Injectable(as: ProfileRepoContract)
class ProfileRepoImpl implements ProfileRepoContract {
  final ProfileRemoteDataSourceContract profileRemoteDataSourceContract;

  ProfileRepoImpl({required this.profileRemoteDataSourceContract});

  @override
  Future<BaseResponse<String>> logout() async {
    final response = await profileRemoteDataSourceContract.logout();
    return response;
  }

  @override
  Future<BaseResponse<ProfileDataEntity>> getProfileData() async {
    final result = await profileRemoteDataSourceContract.getProfileData();

    switch (result) {
      case SuccessBaseResponse<ProfileDataModel> success:
        return SuccessBaseResponse<ProfileDataEntity>(
          data: success.data.toEntity(),
        );
      case ErrorBaseResponse<ProfileDataModel> error:
        return ErrorBaseResponse<ProfileDataEntity>(error: error.error);
    }
  }
}
