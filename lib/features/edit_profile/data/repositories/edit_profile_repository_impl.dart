import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/edit_profile/data/datasources/edit_profile_remote_data_source_contract.dart';
import 'package:tracking_app/features/edit_profile/data/models/edit_profile_model_mapper.dart';
import 'package:tracking_app/features/edit_profile/data/models/edit_profile_request_model.dart';
import 'package:tracking_app/features/edit_profile/data/models/edit_profile_response_model.dart';
import 'package:tracking_app/features/edit_profile/domain/entities/edit_profile_response_entity.dart';
import 'package:tracking_app/features/edit_profile/domain/repositories/edit_profile_repository.dart';

@LazySingleton(as: EditProfileRepository)
class EditProfileRepositoryImpl implements EditProfileRepository {
  final EditProfileRemoteDataSourceContract _remoteDataSource;

  EditProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<EditProfileResponseEntity>> editProfile({
    required String? firstName,
    required String? lastName,
    required String? phone,
  }) async {
    try {
      final request = EditProfileRequestModel(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
      );
      final result = await _remoteDataSource.editProfile(body: request);

      if (result is SuccessBaseResponse<EditProfileResponseModel>) {
        return SuccessBaseResponse<EditProfileResponseEntity>(
          data: result.data.toEntity(),
        );
      } else {
        final error = result as ErrorBaseResponse<EditProfileResponseModel>;
        throw error.error ?? Exception(error.errorMessage);
      }
    } catch (e) {
      return ErrorBaseResponse<EditProfileResponseEntity>(
        error: e,
        errorMessage: e.toString(),
      );
    }
  }
}
