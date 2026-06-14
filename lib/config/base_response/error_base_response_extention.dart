import 'dart:async'; // Fixes TimeoutException error
import 'package:dio/dio.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/generated/l10n.dart';

extension ErrorFilter on ErrorBaseResponse {
  String handleErrorMessage(Object? error) {
    final l10n = S.current;

    // 1️⃣ PRIORITY: Extract message from API response
    if (error is DioException) {
      final data = error.response?.data;
      final messageFromApi = (data is Map<String, dynamic>)
          ? data['message']?.toString()
          : null;

      if (messageFromApi != null && messageFromApi.isNotEmpty) {
        return messageFromApi;
      }
    }

    // 2️⃣ FALLBACK: DioException type-based messages
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return l10n.connectionTimeout;

        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode ?? 0;
          if (statusCode >= 500) return l10n.serverError;
          if (statusCode == 404) return l10n.notFound;
          return l10n.errorMessageGeneric;

        case DioExceptionType.unknown:
          return l10n.networkError;

        default:
          return l10n.errorMessageGeneric;
      }
    }

    // 3️⃣ TimeoutException fallback
    if (error is TimeoutException) {
      return l10n.requestTimeout;
    }

    // 4️⃣ Final fallback
    return l10n.errorMessageGeneric;
  }
}
