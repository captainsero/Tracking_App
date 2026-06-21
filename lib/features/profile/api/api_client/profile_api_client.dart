import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tracking_app/core/constants/api_constants/api_endpoints.dart';
import 'package:tracking_app/features/profile/data/models/profile_data_model.dart';

part 'profile_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio) = _ProfileApiClient;

  @GET(ApiEndpoints.logout)
  Future<String> logout();
  
  @GET(ApiEndpoints.profile)
  Future<ProfileDataModel> getProfileData();
}
