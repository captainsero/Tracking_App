import 'package:tracking_app/core/constants/api_constants/base_urls.dart';

abstract class ApiEndpoints {
  static const String _baseUrl = BaseUrls.trackingAppBaseUrl;
  static const String signUp = '$_baseUrl/drivers/apply';
  static const String login = '$_baseUrl/drivers/signin';
  static const String logout = "$_baseUrl/drivers/logout";
  static const String pendingOrders = "$_baseUrl/orders/pending-orders";
  static const String editProfile = "$_baseUrl/drivers/editProfile";
}
