import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/profile/api/api_client/profile_api_client.dart';
import 'package:tracking_app/features/profile/data/data_sources/profile_remote_data_source_contract.dart';

@Injectable(as: ProfileRemoteDataSourceContract)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSourceContract {
  final ProfileApiClient apiClient;

  ProfileRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<BaseResponse<String>> logout() async {
    try {
      final response = await apiClient.logout();
      return SuccessBaseResponse<String>(data: response);
    } catch (e) {
      return ErrorBaseResponse<String>(error: e);
    }
  }
}
