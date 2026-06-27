import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/secure_storage/secure_storage_service.dart';
import 'package:tracking_app/core/constants/app_keys/secure_storage_keys.dart';
import 'package:tracking_app/features/change_password/data/data_sources/change_password_remote_data_source_contract.dart';
import 'package:tracking_app/features/change_password/data/models/change_password_request.dart';
import 'package:tracking_app/features/change_password/data/models/change_password_response.dart';
import 'package:tracking_app/features/change_password/domain/repo/change_password_repo.dart';

@Injectable(as: ChangePasswordRepo)
class ChangePasswordRepoImpl implements ChangePasswordRepo {
  final ChangePasswordRemoteDataSourceContract _remoteDataSource;
  final SecureStorageService _secureStorage;

  ChangePasswordRepoImpl({
    required ChangePasswordRemoteDataSourceContract remoteDataSource,
    required SecureStorageService secureStorage,
  }) : _remoteDataSource = remoteDataSource,
       _secureStorage = secureStorage;

  @override
  Future<BaseResponse<ChangePasswordResponse>> changePassword({
    required ChangePasswordRequest passwords,
  }) async {
    final response = await _remoteDataSource.changePassword(body: passwords);

    switch (response) {
      case SuccessBaseResponse<ChangePasswordResponse>(:final data):
        final saveTokenResult = await _secureStorage.write(
          key: SecureStorageKeys.token,
          value: data.token,
        );

        if (saveTokenResult is ErrorBaseResponse<String>) {
          return ErrorBaseResponse<ChangePasswordResponse>(
            error: saveTokenResult.error,
          );
        }

        return SuccessBaseResponse<ChangePasswordResponse>(data: data);

      case ErrorBaseResponse<ChangePasswordResponse>(:final error):
        return ErrorBaseResponse<ChangePasswordResponse>(error: error);
    }
  }
}
