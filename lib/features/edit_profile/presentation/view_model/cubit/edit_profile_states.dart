import 'package:equatable/equatable.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/features/edit_profile/domain/entities/edit_profile_response_entity.dart';

class EditProfileStates extends Equatable {
  const EditProfileStates({
    this.updateProfileState = const BaseState<EditProfileResponseEntity>(),
    this.selectedImagePath,
    this.selectedGender,
    this.email,
  });

  /// State for the save/update operation.
  final BaseState<EditProfileResponseEntity> updateProfileState;

  /// Path of the locally picked profile image (not yet uploaded).
  final String? selectedImagePath;

  /// Currently selected gender value: 'male' or 'female'.
  final String? selectedGender;

  /// Read-only email shown in the form (fetched from the profile API).
  final String? email;

  EditProfileStates copyWith({
    BaseState<EditProfileResponseEntity>? updateProfileState,
    String? selectedImagePath,
    bool clearImage = false,
    String? selectedGender,
    String? email,
  }) {
    return EditProfileStates(
      updateProfileState:
          updateProfileState ?? this.updateProfileState,
      selectedImagePath:
          clearImage ? null : selectedImagePath ?? this.selectedImagePath,
      selectedGender: selectedGender ?? this.selectedGender,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [
        updateProfileState,
        selectedImagePath,
        selectedGender,
        email,
      ];
}
