import 'package:equatable/equatable.dart';
import 'package:tracking_app/config/base_state/base_state.dart';

class ProfileState extends Equatable {
  final BaseState<String> logoutState;

  ProfileState({BaseState<String>? logoutState})
    : logoutState = logoutState ?? BaseState<String>(isLoading: false);

  ProfileState copyWith({BaseState<String>? logoutState}) {
    return ProfileState(logoutState: logoutState ?? this.logoutState);
  }

  @override
  List<Object?> get props => [logoutState];
}
