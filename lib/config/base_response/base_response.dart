import 'package:tracking_app/core/errors/app_error.dart';

sealed class BaseResponse<T> {
  const BaseResponse();
}

class SuccessBaseResponse<T> extends BaseResponse<T> {
  final T data;
  const SuccessBaseResponse({required this.data});
}

class ErrorBaseResponse<T> extends BaseResponse<T> {
  final Object? error;
  final String? errorMessage;

  const ErrorBaseResponse({this.error, this.errorMessage});

  AppError get appError => AppError.from(error);
}
