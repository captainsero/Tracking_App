sealed class EditProfileEvents {
  const EditProfileEvents();

  factory EditProfileEvents.updateProfileEvent() = UpdateProfileEvent;
  factory EditProfileEvents.pickImageEvent() = PickImageEvent;

  void when({
    required Function() updateProfileEvent,
    required Function() pickImageEvent,
  }) {
    if (this is UpdateProfileEvent) {
      updateProfileEvent();
    } else if (this is PickImageEvent) {
      pickImageEvent();
    }
  }
}

class UpdateProfileEvent extends EditProfileEvents {}

class PickImageEvent extends EditProfileEvents {}
