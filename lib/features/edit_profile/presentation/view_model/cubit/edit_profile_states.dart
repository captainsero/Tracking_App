import 'package:equatable/equatable.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/features/edit_profile/domain/entities/edit_profile_response_entity.dart';

class EditProfileStates extends Equatable {
  const EditProfileStates({
    this.updateProfileState = const BaseState<EditProfileResponseEntity>(),
    this.selectedImagePath,
    this.selectedGender,
  });

  /// State for the save/update operation.
  final BaseState<EditProfileResponseEntity> updateProfileState;

  /// Path of the locally picked profile image (not yet uploaded).
  final String? selectedImagePath;

  /// Currently selected gender value: 'male' or 'female'.
  final String? selectedGender;

  EditProfileStates copyWith({
    BaseState<EditProfileResponseEntity>? updateProfileState,
    String? selectedImagePath,
    bool clearImage = false,
    String? selectedGender,
  }) {
    return EditProfileStates(
      updateProfileState:
          updateProfileState ?? this.updateProfileState,
      selectedImagePath:
          clearImage ? null : selectedImagePath ?? this.selectedImagePath,
      selectedGender: selectedGender ?? this.selectedGender,
    );
  }

  @override
  List<Object?> get props => [
        updateProfileState,
        selectedImagePath,
        selectedGender,
      ];
}
