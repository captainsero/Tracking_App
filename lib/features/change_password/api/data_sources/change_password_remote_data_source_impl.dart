import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/change_password/api/api_client/change_password_api_client.dart';
import 'package:tracking_app/features/change_password/data/data_sources/change_password_remote_data_source_contract.dart';
import 'package:tracking_app/features/change_password/data/models/change_password_request.dart';
import 'package:tracking_app/features/change_password/data/models/change_password_response.dart';

@LazySingleton(as: ChangePasswordRemoteDataSourceContract)
class ChangePasswordRemoteDataSourceImpl
    implements ChangePasswordRemoteDataSourceContract {
  final ChangePasswordApiClient apiClient;

  ChangePasswordRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<BaseResponse<ChangePasswordResponse>> changePassword({
    required ChangePasswordRequest body,
  }) async {
    try {
      final response = await apiClient.changePassword(body: body);
      return SuccessBaseResponse<ChangePasswordResponse>(data: response);
    } catch (e) {
      return ErrorBaseResponse<ChangePasswordResponse>(error: e);
    }
  }
}
