import '../../domain/entities/login_response_entity.dart';
import '../../domain/entities/login_params.dart';
import 'login_request_model.dart';
import 'login_response_model.dart';

extension LoginResponseModelMapper on LoginResponseModel {
  /// Convert Model to Entity
  LoginResponseEntity toEntity() {
    return LoginResponseEntity(message: message ?? '', token: token ?? '');
  }
}

extension LoginParamsMapper on LoginParams {
  /// Convert Params to Request Model
  LoginRequestModel toModel() {
    return LoginRequestModel(email: email, password: password);
  }
}
