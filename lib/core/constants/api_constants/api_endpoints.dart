import 'package:tracking_app/core/constants/api_constants/base_urls.dart';

abstract class ApiEndpoints {
  static const String _baseUrl = BaseUrls.trackingAppBaseUrl;
  // TODO: Add Api End Points
  static const String login = '$_baseUrl/drivers/signin';
}
