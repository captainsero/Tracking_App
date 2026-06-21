sealed class ProfileEvent {
  const ProfileEvent();

  factory ProfileEvent.loadProfileData() = LoadProfileDataEvent;

  void when({required Function() loadProfileData}) {
    if (this is LoadProfileDataEvent) {
      loadProfileData();
    }
  }
}

class LogoutEvent extends ProfileEvent {}
class LoadProfileDataEvent extends ProfileEvent {}