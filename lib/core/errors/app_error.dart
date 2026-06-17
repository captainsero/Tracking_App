import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:tracking_app/config/secure_storage/secure_storage_service.dart';

sealed class AppError {
  const AppError();

  factory AppError.from(Object? error) {
    if (error is DioException) {
      final data = error.response?.data;
      final apiMessage = (data is Map<String, dynamic>)
          ? data['message']?.toString()
          : null;

      if (apiMessage != null && apiMessage.isNotEmpty) {
        return ApiMessageError(apiMessage);
      }

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const ConnectionTimeoutError();

        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode ?? 0;
          if (statusCode >= 500) return ServerError(statusCode);
          if (statusCode == 404) return const NotFoundError();
          return const UnknownError();

        case DioExceptionType.unknown:
          return const NetworkError();

        default:
          return const UnknownError();
      }
    }

    if (error is TimeoutException) return const RequestTimeoutError();

    if (error is KeyNotFoundException) {
      return LocalStorageError(key: error.key);
    }

    if (error is PlatformException) {
      return const LocalStorageError();
    }

    return const UnknownError();
  }
}

class ConnectionTimeoutError extends AppError {
  const ConnectionTimeoutError();
}

class RequestTimeoutError extends AppError {
  const RequestTimeoutError();
}

class NetworkError extends AppError {
  const NetworkError();
}

class NotFoundError extends AppError {
  const NotFoundError();
}

class ServerError extends AppError {
  final int statusCode;
  const ServerError(this.statusCode);
}

class ApiMessageError extends AppError {
  final String message;
  const ApiMessageError(this.message);
}

class UnknownError extends AppError {
  const UnknownError();
}

class LocalStorageError extends AppError {
  final String? key;
  const LocalStorageError({this.key});
}
