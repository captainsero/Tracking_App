part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  final BaseState<ForgotPasswordResponseModel> forgotPasswordState;
  final BaseState<ForgotPasswordResponseModel> verifyResetState;
  final BaseState<ForgotPasswordResponseModel> resetPasswordState;

  ForgotPasswordState({
    BaseState<ForgotPasswordResponseModel>? forgotPasswordState,
    BaseState<ForgotPasswordResponseModel>? verifyResetState,
    BaseState<ForgotPasswordResponseModel>? resetPasswordState,
  }) : forgotPasswordState = forgotPasswordState ?? BaseState(isLoading: false),
       verifyResetState = verifyResetState ?? BaseState(isLoading: false),
       resetPasswordState = resetPasswordState ?? BaseState(isLoading: false);

  ForgotPasswordState copyWith({
    BaseState<ForgotPasswordResponseModel>? forgotPasswordState,
    BaseState<ForgotPasswordResponseModel>? verifyResetState,
    BaseState<ForgotPasswordResponseModel>? resetPasswordState,
  }) {
    return ForgotPasswordState(
      forgotPasswordState: forgotPasswordState ?? this.forgotPasswordState,
      verifyResetState: verifyResetState ?? this.verifyResetState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
    );
  }

  @override
  List<Object?> get props => [
    forgotPasswordState,
    verifyResetState,
    resetPasswordState,
  ];
}
