import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tracking_app/core/constants/api_constants/api_endpoints.dart';
import 'package:tracking_app/features/edit_profile/data/models/edit_profile_request_model.dart';
import 'package:tracking_app/features/edit_profile/data/models/edit_profile_response_model.dart';

part 'edit_profile_api_client.g.dart';

@RestApi()
@lazySingleton
abstract class EditProfileApiClient {
  @factoryMethod
  factory EditProfileApiClient(Dio dio) = _EditProfileApiClient;

  @PUT(ApiEndpoints.editProfile)
  Future<EditProfileResponseModel> editProfile(@Body() EditProfileRequestModel request);
}
