import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/edit_profile/domain/entities/edit_profile_response_entity.dart';

abstract class EditProfileRepository {
  Future<BaseResponse<EditProfileResponseEntity>> editProfile({
    required String? firstName,
    required String? lastName,
    required String? phone,
  });
}
