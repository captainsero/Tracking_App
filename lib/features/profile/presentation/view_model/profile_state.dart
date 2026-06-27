import 'package:equatable/equatable.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/features/profile/domain/entities/profile_data_entity.dart';

class ProfileState extends Equatable {
  final BaseState<String> logoutState;
  final BaseState<ProfileDataEntity> profileDataState;

  const ProfileState({
    this.logoutState = const BaseState<String>(isLoading: false),
    this.profileDataState = const BaseState<ProfileDataEntity>(isLoading: false),
  });

  ProfileState copyWith({
    BaseState<String>? logoutState,
    BaseState<ProfileDataEntity>? profileDataState,
  }) {
    return ProfileState(
      logoutState: logoutState ?? this.logoutState,
      profileDataState: profileDataState ?? this.profileDataState,
    );
  }

  @override
  List<Object?> get props => [logoutState, profileDataState];
}