import 'package:tracking_app/core/constants/api_constants/base_urls.dart';

abstract class ApiEndpoints {
  static const String _baseUrl = BaseUrls.trackingAppBaseUrl;
  static const String forgotPassword = "$_baseUrl/auth/forgotPassword";
  static const String verifyReset = "$_baseUrl/auth/verifyResetCode";
  static const String resetPassword = "$_baseUrl/auth/resetPassword";
}
