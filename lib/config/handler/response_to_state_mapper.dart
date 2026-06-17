import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/core/errors/app_error_localizer.dart';
import 'package:tracking_app/generated/l10n.dart';

abstract class ResponseToStateMapper {
  static BaseState<T> handle<T>(BaseResponse<T> response) {
    switch (response) {
      case SuccessBaseResponse<T>():
        return BaseState(
          data: response.data,
          isLoading: false,
          errorMessage: null,
        );
      case ErrorBaseResponse<T>():
        return BaseState(
          data: null,
          isLoading: false,
          errorMessage:
              response.errorMessage ?? response.appError.localize(S.current),
        );
    }
  }
}
