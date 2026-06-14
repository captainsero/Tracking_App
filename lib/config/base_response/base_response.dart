import 'package:tracking_app/config/base_response/error_base_response_extention.dart';

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

  String getErrorMessage() => handleErrorMessage(error);
}
