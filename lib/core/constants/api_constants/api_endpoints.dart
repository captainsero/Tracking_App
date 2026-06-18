import 'package:tracking_app/core/constants/api_constants/base_urls.dart';

abstract class ApiEndpoints {
  static const String _baseUrl = BaseUrls.trackingAppBaseUrl;
  static const String logout = "$_baseUrl/drivers/logout";
}
