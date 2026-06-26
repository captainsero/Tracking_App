import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/edit_profile/api/api_client/edit_profile_api_client.dart';
import 'package:tracking_app/features/edit_profile/data/datasources/edit_profile_remote_data_source_contract.dart';
import 'package:tracking_app/features/edit_profile/data/models/edit_profile_request_model.dart';
import 'package:tracking_app/features/edit_profile/data/models/edit_profile_response_model.dart';

@LazySingleton(as: EditProfileRemoteDataSourceContract)
class EditProfileRemoteDataSourceImpl
    implements EditProfileRemoteDataSourceContract {
  final EditProfileApiClient _apiClient;

  EditProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<EditProfileResponseModel>> editProfile({
    required EditProfileRequestModel body,
  }) async {
    try {
      final response = await _apiClient.editProfile(body);
      return SuccessBaseResponse<EditProfileResponseModel>(data: response);
    } catch (e) {
      return ErrorBaseResponse<EditProfileResponseModel>(
        error: e,
        errorMessage: e.toString(),
      );
    }
  }
}
