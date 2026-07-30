import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/auth/sign_up/domain/entities/sign_up_entity.dart';

abstract class SignUpRepo {
  Future<BaseResponse<void>> signUp(SignUpEntity entity);
}
