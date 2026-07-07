import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/edit_profile/data/models/edit_profile_request_model.dart';
import 'package:tracking_app/features/edit_profile/data/models/edit_profile_response_model.dart';

abstract interface class EditProfileRemoteDataSourceContract {
  Future<BaseResponse<EditProfileResponseModel>> editProfile({
    required EditProfileRequestModel body,
  });
}