import 'package:equatable/equatable.dart';

enum SignUpStatus { initial, loading, success, failure }

class SignUpState extends Equatable {
  final SignUpStatus status;
  final String? errorMessage;

  const SignUpState({
    this.status = SignUpStatus.initial,
    this.errorMessage,
  });

  /// Note: errorMessage is NOT inherited from the previous state on
  /// purpose (mirrors BaseState, which is rebuilt fresh on every emit
  /// instead of using copyWith). Pass it explicitly when transitioning
  /// to SignUpStatus.failure; any other transition clears it.
  SignUpState copyWith({SignUpStatus? status, String? errorMessage}) =>
      SignUpState(
        status: status ?? this.status,
        errorMessage: errorMessage,
      );

  bool get isLoading => status == SignUpStatus.loading;
  bool get isSuccess => status == SignUpStatus.success;
  bool get isFailure => status == SignUpStatus.failure;

  @override
  List<Object?> get props => [status, errorMessage];
}
