import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/change_password/data/models/change_password_request.dart';
import 'package:tracking_app/features/change_password/data/models/change_password_response.dart';

abstract class ChangePasswordRemoteDataSourceContract {
  Future<BaseResponse<ChangePasswordResponse>> changePassword({
    required ChangePasswordRequest body,
  });
}
