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

    // الـ fakeData دي مؤقتة لحد ما الـ API يشتغل فعليًا
    final ProfileDataEntity fakeData = ProfileDataEntity(
      id: '1',
      firstName: 'Kareem',
      lastName: 'Yasser',
      email: 'kareem.yasser@example.com',
      phone: '+201016473761',
      photo: 'assets/images/Gemini image profile.png',
    );

    switch (result) {
      case SuccessBaseResponse<ProfileDataModel> success:
        return SuccessBaseResponse<ProfileDataEntity>(data: fakeData);

      case ErrorBaseResponse<ProfileDataModel> error:
        // TODO: لما الـ API يشتغل فعليًا، رجّع الـ error الحقيقي بدل الـ fakeData:
        // final Object error = "Failed to fetch profile data";
        // return ErrorBaseResponse<ProfileDataEntity>(error: error);
        return SuccessBaseResponse<ProfileDataEntity>(data: fakeData);
    }
  }
}
