import 'package:equatable/equatable.dart';
import 'package:tracking_app/features/edit_profile/data/models/edit_profile_response_model.dart';

/// The response entity returned from the edit-profile use-case.
/// [DriverEntity] is defined in [edit_profile_response_model.dart] alongside
/// [DriverModel] so that the mapping extension can live in one place.
class EditProfileResponseEntity extends Equatable {
  final String message;
  final DriverEntity driver;

  const EditProfileResponseEntity({
    required this.message,
    required this.driver,
  });

  @override
  List<Object?> get props => [message, driver];
}
