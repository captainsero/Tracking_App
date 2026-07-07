import 'package:tracking_app/features/edit_profile/data/models/edit_profile_response_model.dart';
import 'package:tracking_app/features/edit_profile/domain/entities/edit_profile_response_entity.dart';

extension EditProfileResponseModelMapper on EditProfileResponseModel {
  EditProfileResponseEntity toEntity() {
    return EditProfileResponseEntity(
      message: message,
      driver: driver.toDriverEntity(),
    );
  }
}
