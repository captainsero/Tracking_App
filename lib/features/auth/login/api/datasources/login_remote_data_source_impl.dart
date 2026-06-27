import 'package:tracking_app/config/base_response/base_response.dart';
import '../../data/datasources/login_remote_data_source_contract.dart';
import '../../data/models/login_request_model.dart';
import '../../data/models/login_response_model.dart';
import 'package:injectable/injectable.dart';

import '../../api/api_client/login_api_client.dart';

@LazySingleton(as: LoginRemoteDataSourceContract)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSourceContract {
  final LoginApiClient apiClient;

  LoginRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<BaseResponse<LoginResponseModel>> loginUser({
    required LoginRequestModel body,
    required bool rememberMe,
  }) async {
    try {
      final response = await apiClient.login(body);
      return SuccessBaseResponse<LoginResponseModel>(data: response);
    } catch (e) {
      return ErrorBaseResponse<LoginResponseModel>(
        error: e,
        errorMessage: e.toString(),
      );
    }
  }
}
