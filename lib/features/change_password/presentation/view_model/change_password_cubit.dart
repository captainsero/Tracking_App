import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/config/handler/response_to_state_mapper.dart';
import 'package:tracking_app/features/change_password/data/models/change_password_request.dart';
import 'package:tracking_app/features/change_password/data/models/change_password_response.dart';
import 'package:tracking_app/features/change_password/domain/use_cases/change_password_use_case.dart';
import 'package:tracking_app/features/change_password/presentation/view_model/change_password_event.dart';
import 'package:tracking_app/features/change_password/presentation/view_model/change_password_state.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _useCase;

  ChangePasswordCubit(this._useCase) : super(const ChangePasswordState());

  void doEvent(ChangePasswordEvent event) {
    _changePassword(passwords: event.passwords);
  }

  Future<void> _changePassword({
    required ChangePasswordRequest passwords,
  }) async {
    if (state.changePasswordState.isLoading == true) return;

    emit(
      state.copyWith(
        apiError: null,
        changePasswordState: const BaseState<ChangePasswordResponse>(
          isLoading: true,
        ),
      ),
    );

    final response = await _useCase(passwords: passwords);
    final handler = ResponseToStateMapper.handle<ChangePasswordResponse>(
      response,
    );

    emit(
      state.copyWith(
        apiError: handler.errorMessage,
        changePasswordState: handler,
      ),
    );
  }
}
