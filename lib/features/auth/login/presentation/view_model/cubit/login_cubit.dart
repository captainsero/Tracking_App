import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import '../../../domain/entities/login_params.dart';
import '../../../domain/entities/login_response_entity.dart';
import '../../../domain/use_cases/login_use_case.dart';
import 'login_events.dart';
import 'login_states.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this._loginUserUseCase) : super(LoginStates());

  final LoginUseCase _loginUserUseCase;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void doIntent(LoginEvents event) {
    event.when(loginUserEvent: _login);
  }

  void toggleRememberMe(bool value) {
    emit(state.copyWith(isRememberMe: value));
  }

  Future<void> _login() async {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      return;
    }

    emit(state.copyWith(loginState: const BaseState(isLoading: true)));
    final result = await _loginUserUseCase.call(
      params: LoginParams(
        email: emailController.text.trim(),
        password: passwordController.text,
        rememberMe: state.isRememberMe,
      ),
    );
    switch (result) {
      case SuccessBaseResponse<LoginResponseEntity>(:final data):
        emit(state.copyWith(
          loginState: BaseState(isLoading: false, data: data),
        ));
      case ErrorBaseResponse<LoginResponseEntity>(:final errorMessage):
        emit(state.copyWith(
          loginState: BaseState(isLoading: false, errorMessage: errorMessage),
        ));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
