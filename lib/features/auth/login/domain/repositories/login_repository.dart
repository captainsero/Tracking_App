import 'package:tracking_app/config/base_response/base_response.dart';
import '../entities/login_response_entity.dart';

abstract class LoginRepository {
  Future<BaseResponse<LoginResponseEntity>> loginUser({
    required String email,
    required String password,
    required bool rememberMe,
  });
}
