import 'package:tracking_app/config/base_response/base_response.dart';

import '../models/login_request_model.dart';
import '../models/login_response_model.dart';

abstract interface class LoginRemoteDataSourceContract {
  Future<BaseResponse<LoginResponseModel>> loginUser({
    required LoginRequestModel body,
    required bool rememberMe,
  });
}