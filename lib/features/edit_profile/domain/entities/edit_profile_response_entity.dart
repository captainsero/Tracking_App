import 'package:equatable/equatable.dart';
import 'package:tracking_app/features/edit_profile/data/models/edit_profile_response_model.dart';

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
