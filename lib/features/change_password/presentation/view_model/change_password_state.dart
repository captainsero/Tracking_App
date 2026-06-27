import 'package:equatable/equatable.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/features/change_password/data/models/change_password_response.dart';

class ChangePasswordState extends Equatable {
  final BaseState<ChangePasswordResponse> changePasswordState;
  final String? apiError;

  const ChangePasswordState({
    this.changePasswordState = const BaseState<ChangePasswordResponse>(
      isLoading: false,
    ),
    this.apiError,
  });

  ChangePasswordState copyWith({
    BaseState<ChangePasswordResponse>? changePasswordState,
    String? apiError,
  }) {
    return ChangePasswordState(
      changePasswordState: changePasswordState ?? this.changePasswordState,
      apiError: apiError,
    );
  }

  @override
  List<Object?> get props => [changePasswordState, apiError];
}
