import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/config/handler/response_to_state_mapper.dart';
import 'package:tracking_app/features/edit_profile/domain/entities/edit_profile_request_entity.dart';
import 'package:tracking_app/features/edit_profile/domain/entities/edit_profile_response_entity.dart';
import 'package:tracking_app/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';

import 'edit_profile_events.dart';
import 'edit_profile_states.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileStates> {
  EditProfileCubit(this._editProfileUseCase) : super(const EditProfileStates());

  final EditProfileUseCase _editProfileUseCase;
  final _imagePicker = ImagePicker();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  /// Pre-populate fields with current user data coming from the profile screen.
  void initFields({
    required String firstName,
    required String lastName,
    required String phone,
    required String gender,
  }) {
    firstNameController.text = firstName;
    lastNameController.text = lastName;
    phoneController.text = phone;
    emit(state.copyWith(selectedGender: gender));
  }

  /// Called when the user taps a gender radio button.
  void selectGender(String gender) {
    emit(state.copyWith(selectedGender: gender));
  }

  void doIntent(EditProfileEvents event) {
    event.when(updateProfileEvent: _updateProfile, pickImageEvent: _pickImage);
  }

  Future<void> _updateProfile() async {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final phone = phoneController.text.trim();
    final gender = state.selectedGender;

    // At least one field must have a value.
    if (firstName.isEmpty &&
        lastName.isEmpty &&
        phone.isEmpty &&
        gender == null) {
      return;
    }

    emit(
      state.copyWith(
        updateProfileState: const BaseState<EditProfileResponseEntity>(
          isLoading: true,
        ),
      ),
    );

    final entity = EditProfileRequestEntity(
      firstName: firstName.isEmpty ? null : firstName,
      lastName: lastName.isEmpty ? null : lastName,
      phone: phone.isEmpty ? null : phone,
      gender: gender,
    );

    final result = await _editProfileUseCase.call(entity: entity);

    emit(
      state.copyWith(
        updateProfileState: ResponseToStateMapper.handle(result),
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      emit(state.copyWith(selectedImagePath: pickedFile.path));
    }
  }

  @override
  Future<void> close() {
    if (isClosed) return super.close();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
