import 'package:tracking_app/config/base_response/base_response.dart';

import '../entities/login_response_entity.dart';
import 'package:injectable/injectable.dart';

import '../repositories/login_repository.dart';

@lazySingleton
class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase({required this.repository});

  Future<BaseResponse<LoginResponseEntity>> call({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    return await repository.loginUser(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );
  }
}
