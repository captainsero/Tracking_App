import 'package:tracking_app/core/constants/api_constants/base_urls.dart';

abstract class ApiEndpoints {
  static const String _baseUrl = BaseUrls.trackingAppBaseUrl;
  static const String signUp = '$_baseUrl/drivers/apply';
  // TODO: Add Api End Points
  static const String login = '$_baseUrl/drivers/signin';
  static const String logout = "$_baseUrl/drivers/logout";
  static const String profile = "$_baseUrl/drivers/profile-data";
    static const String editVehicleInfo = "$_baseUrl/drivers/editProfile";

}
