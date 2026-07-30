import 'package:tracking_app/core/constants/api_constants/base_urls.dart';

abstract class ApiEndpoints {
  static const String _baseUrl = BaseUrls.trackingAppBaseUrl;
  static const String forgotPassword = "$_baseUrl/auth/forgotPassword";
  static const String verifyReset = "$_baseUrl/auth/verifyResetCode";
  static const String resetPassword = "$_baseUrl/auth/resetPassword";
  static const String signUp = '$_baseUrl/drivers/apply';
  static const String login = '$_baseUrl/drivers/signin';
  static const String logout = "$_baseUrl/drivers/logout";
  static const String profile = "$_baseUrl/drivers/profile-data";
  static const String changePassword = "$_baseUrl/drivers/change-password";
  static const String pendingOrders = "$_baseUrl/orders/pending-orders";
}
