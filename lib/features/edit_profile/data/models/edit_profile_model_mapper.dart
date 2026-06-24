import 'package:tracking_app/features/edit_profile/data/models/edit_profile_response_model.dart';
import 'package:tracking_app/features/edit_profile/domain/entities/edit_profile_response_entity.dart';

extension EditProfileResponseModelMapper on EditProfileResponseModel {
  /// Convert Model to Entity
  EditProfileResponseEntity toEntity() {
    return EditProfileResponseEntity(
      message: message,
      driver: driver.toDriverEntity(),
    );
  }
}

extension DriverModelMapper on DriverModel {
  DriverEntity toDriverEntity() {
    return DriverEntity(
      id: id,
      country: country,
      firstName: firstName,
      lastName: lastName,
      vehicleType: vehicleType,
      vehicleNumber: vehicleNumber,
      vehicleLicense: vehicleLicense,
      nid: nid,
      nidImg: nidImg,
      email: email,
      password: password,
      gender: gender,
      phone: phone,
      photo: photo,
      role: role,
      createdAt: createdAt,
    );
  }
}
