import 'package:tracking_app/config/base_response/base_response.dart';
import '../entities/login_params.dart';
import '../entities/login_response_entity.dart';

abstract interface class LoginRepository {
  Future<BaseResponse<LoginResponseEntity>> loginUser({
    required LoginParams params,
  });
}
