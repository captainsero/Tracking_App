import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/handler/secure_storage_handler.dart';
import 'package:tracking_app/config/secure_storage/secure_storage_service.dart';
import 'package:tracking_app/core/constants/app_keys/api_keys.dart';
import 'package:tracking_app/core/constants/app_keys/secure_storage_keys.dart';

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
    if (err.response?.statusCode == 401) {
      // Token expired

      await secureStorage.delete(key: SecureStorageKeys.token);
    }

    handler.next(err);
  }
}
