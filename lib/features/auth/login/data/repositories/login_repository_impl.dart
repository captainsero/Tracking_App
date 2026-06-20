import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/auth/login/data/models/login_response_model.dart';
import '../models/login_model_mapper.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/login_response_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_data_source_contract.dart';
import '../models/login_request_model.dart';

@LazySingleton(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSourceContract _remoteDataSource;

  LoginRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<LoginResponseEntity>> loginUser({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      final request = LoginRequestModel(email: email, password: password);
      final result = await _remoteDataSource.loginUser(
        body: request,
        rememberMe: rememberMe,
      );
      if (result is SuccessBaseResponse<LoginResponseModel>) {
        return SuccessBaseResponse<LoginResponseEntity>(
          data: result.data.toEntity(),
        );
      } else {
        final error = result as ErrorBaseResponse<LoginResponseModel>;
        throw error.error ?? Exception(error.errorMessage);
      }
    } catch (e) {
      return ErrorBaseResponse<LoginResponseEntity>(
        error: e,
        errorMessage: e.toString(),
      );
    }
  }
}
