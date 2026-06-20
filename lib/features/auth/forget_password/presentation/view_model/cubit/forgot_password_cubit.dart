import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/config/handler/response_to_state_mapper.dart';
import 'package:tracking_app/config/secure_storage/secure_storage_service.dart';
import 'package:tracking_app/core/constants/app_keys/secure_storage_keys.dart';

import 'package:tracking_app/features/auth/forget_password/data/models/requests/forgot_password_request.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/requests/reset_password_request.dart';
import 'package:tracking_app/features/auth/forget_password/data/models/responses/forgot_password_response_model.dart';
import 'package:tracking_app/features/auth/forget_password/domain/use_cases/forgot_password_use_case.dart';
import 'package:tracking_app/features/auth/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:tracking_app/features/auth/forget_password/domain/use_cases/verify_reset_use_case.dart';
part 'forgot_password_state.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final VerifyResetUseCase _verifyResetUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final SecureStorageService _secureStorageService;

  ForgotPasswordCubit(
    super.initialState, {
    required ForgotPasswordUseCase forgotPasswordUseCase,
    required VerifyResetUseCase verifyResetUseCase,
    required ResetPasswordUseCase resetPasswordUseCase,
    required SecureStorageService secureStorageService,
  }) : _secureStorageService = secureStorageService,
       _forgotPasswordUseCase = forgotPasswordUseCase,
       _verifyResetUseCase = verifyResetUseCase,
       _resetPasswordUseCase = resetPasswordUseCase;

  Future<void> forgotPassword(ForgotPasswordRequest email) async {
    emit(state.copyWith(forgotPasswordState: const BaseState(isLoading: true)));

    final response = await _forgotPasswordUseCase.call(email);

    final handler = ResponseToStateMapper.handle(response);
    emit(
      state.copyWith(
        forgotPasswordState: BaseState(
          isLoading: handler.isLoading,
          data: handler.data,
          errorMessage: handler.errorMessage,
        ),
      ),
    );
  }

  Future<void> verifyReset(String resetCode) async {
    emit(state.copyWith(verifyResetState: const BaseState(isLoading: true)));

    final response = await _verifyResetUseCase.call(resetCode);

    final handler = ResponseToStateMapper.handle(response);
    emit(
      state.copyWith(
        verifyResetState: BaseState(
          isLoading: handler.isLoading,
          data: handler.data,
          errorMessage: handler.errorMessage,
        ),
      ),
    );
  }

  Future<void> resetPassword(ResetPasswordRequest body) async {
    emit(state.copyWith(resetPasswordState: const BaseState(isLoading: true)));

    final response = await _resetPasswordUseCase.call(body);

    final handler = ResponseToStateMapper.handle(response);
    emit(
      state.copyWith(
        resetPasswordState: BaseState(
          isLoading: handler.isLoading,
          data: handler.data,
          errorMessage: handler.errorMessage,
        ),
      ),
    );
  }

  Future<void> resendCode() async {
    final emailResponse = await _secureStorageService.read(
      key: SecureStorageKeys.userEmail,
    );

    switch (emailResponse) {
      case SuccessBaseResponse<String>(data: final email):
        await forgotPassword(ForgotPasswordRequest(email: email));
        break;

      case ErrorBaseResponse<String>():
        emit(
          state.copyWith(
            forgotPasswordState: BaseState(
              isLoading: false,
              errorMessage: 'Please start the process again.',
            ),
          ),
        );
        break;
    }
  }

  Future<void> clearError() async {
    emit(
      state.copyWith(
        forgotPasswordState: BaseState(isLoading: false),
        verifyResetState: BaseState(isLoading: false),
        resetPasswordState: BaseState(isLoading: false),
      ),
    );
  }
}
