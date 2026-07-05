import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/edit_profile/data/datasources/edit_profile_remote_data_source_contract.dart';
import 'package:tracking_app/features/edit_profile/data/models/edit_profile_request_model.dart';
import 'package:tracking_app/features/edit_profile/data/models/edit_profile_response_model.dart';
import 'package:tracking_app/features/edit_profile/data/models/edit_profile_response_model_mapper.dart';
import 'package:tracking_app/features/edit_profile/domain/entities/edit_profile_request_entity.dart';
import 'package:tracking_app/features/edit_profile/domain/entities/edit_profile_response_entity.dart';
import 'package:tracking_app/features/edit_profile/domain/repositories/edit_profile_repository.dart';

@LazySingleton(as: EditProfileRepository)
class EditProfileRepositoryImpl implements EditProfileRepository {
  final EditProfileRemoteDataSourceContract _remoteDataSource;

  EditProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<EditProfileResponseEntity>> editProfile({
    required EditProfileRequestEntity entity,
  }) async {
    final request = EditProfileRequestModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      phone: entity.phone,
      gender: entity.gender,
    );

    final result = await _remoteDataSource.editProfile(body: request);

    return switch (result) {
      SuccessBaseResponse<EditProfileResponseModel>() =>
        SuccessBaseResponse<EditProfileResponseEntity>(
          data: result.data.toEntity(),
        ),
      ErrorBaseResponse<EditProfileResponseModel>() =>
        ErrorBaseResponse<EditProfileResponseEntity>(error: result.error),
    };
  }
}