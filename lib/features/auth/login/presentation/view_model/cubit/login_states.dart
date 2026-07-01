import 'package:equatable/equatable.dart';
import 'package:tracking_app/config/base_state/base_state.dart';

import '../../../domain/entities/login_response_entity.dart';

class LoginStates extends Equatable {
  LoginStates({
    this.loginState = const BaseState<LoginResponseEntity>(),
    this.isRememberMe = false,
  });

  final BaseState<LoginResponseEntity> loginState;
  final bool isRememberMe;
  LoginStates copyWith({
    BaseState<LoginResponseEntity>? loginState,
    bool? isRememberMe,
  }) {
    return LoginStates(
      loginState: loginState ?? this.loginState,
      isRememberMe: isRememberMe ?? this.isRememberMe,
    );
  }
  
  @override
  List<Object?> get props => [loginState, isRememberMe];
}
