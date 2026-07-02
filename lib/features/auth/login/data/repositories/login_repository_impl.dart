import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/features/auth/login/domain/entities/login_params.dart';
import 'package:tracking_app/features/auth/login/domain/entities/login_response_entity.dart';
import 'package:tracking_app/features/auth/login/domain/repositories/login_repository.dart';
import 'package:tracking_app/features/auth/login/data/datasources/login_remote_data_source_contract.dart';
import 'package:tracking_app/features/auth/login/data/models/login_model_mapper.dart';
import 'package:tracking_app/features/auth/login/data/models/login_response_model.dart';

@LazySingleton(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSourceContract _remoteDataSource;

  LoginRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<LoginResponseEntity>> loginUser({
    required LoginParams params,
  }) async {
    final result = await _remoteDataSource.loginUser(
      body: params.toModel(),
      rememberMe: params.rememberMe,
    );

    return switch (result) {
      SuccessBaseResponse<LoginResponseModel>(:final data) =>
        SuccessBaseResponse<LoginResponseEntity>(data: data.toEntity()),
      ErrorBaseResponse<LoginResponseModel>(:final error, errorMessage: final msg) =>
        ErrorBaseResponse<LoginResponseEntity>(
          error: error,
          errorMessage: msg ?? error?.toString(),
        ),
    };
  }
}
