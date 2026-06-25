import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/handler/secure_storage_handler.dart';
import 'package:tracking_app/config/secure_storage/secure_storage_service.dart';
import 'package:tracking_app/core/constants/app_keys/api_keys.dart';
import 'package:tracking_app/core/constants/app_keys/secure_storage_keys.dart';
import 'package:tracking_app/core/router/app_router.dart';
import 'package:tracking_app/core/router/route_path.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  final SecureStorageService secureStorage;

  AuthInterceptor(this.secureStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final response = await secureStorage.read(key: SecureStorageKeys.token);

    final token = SecureStorageHandler.handle<String>(response);

    if (token != null && token.isNotEmpty) {
      options.headers[ApiKeys.authorization] = '${ApiKeys.bearer} $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final responseData = err.response?.data;
    final bool isInvalidTokenError = responseData is Map &&
        (responseData['error']?.toString().contains('invalid token') == true ||
            responseData['message']?.toString().contains('invalid token') ==
                true);

    if (err.response?.statusCode == 401 || isInvalidTokenError) {
      // Token expired or invalid
      await secureStorage.delete(key: SecureStorageKeys.token);
      // Redirect to login page
      AppRouter.goRouter.go(RoutePath.login);
    }

    handler.next(err);
  }
}
