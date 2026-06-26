import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/auth/sign_up/api_client/sign_up_api_client.dart';
import 'package:tracking_app/features/auth/sign_up/data/models/sign_up_request_model.dart';

abstract class SignUpRemoteDataSource {
  Future<BaseResponse<void>> signUp({
    required SignUpRequestModel model,
    required String vehicleLicensePath,
    required String nidImagePath,
  });
}

@Injectable(as: SignUpRemoteDataSource)
class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  final SignUpApiClient _apiClient;
  const SignUpRemoteDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<void>> signUp({
    required SignUpRequestModel model,
    required String vehicleLicensePath,
    required String nidImagePath,
  }) async {
    try {
      final vehicleLicenseFile = await MultipartFile.fromFile(
        vehicleLicensePath,
        filename: vehicleLicensePath.split('/').last,
      );
      final nidImageFile = await MultipartFile.fromFile(
        nidImagePath,
        filename: nidImagePath.split('/').last,
      );

      await _apiClient.signUp(
        model.country,
        model.firstName,
        model.lastName,
        model.vehicleType,
        model.vehicleNumber,
        model.email,
        model.phone,
        model.nid,
        model.password,
        model.rePassword,
        model.gender,
        vehicleLicenseFile,
        nidImageFile,
      );
      return const SuccessBaseResponse(data: null);
    } catch (e) {
      return ErrorBaseResponse(error: e);
    }
  }
}
