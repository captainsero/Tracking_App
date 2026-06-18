import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/core/errors/app_error_localizer.dart';
import 'package:tracking_app/generated/l10n.dart';
import 'package:tracking_app/features/auth/sign_up/domain/entities/sign_up_entity.dart';
import 'package:tracking_app/features/auth/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'sign_up_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase _useCase;
  SignUpCubit(this._useCase) : super(const SignUpState());

  Future<void> signUp(SignUpEntity entity) async {
    emit(state.copyWith(status: SignUpStatus.loading));
    final result = await _useCase(entity);
    switch (result) {
      case SuccessBaseResponse():
        emit(state.copyWith(status: SignUpStatus.success));
      case ErrorBaseResponse():
        emit(state.copyWith(
          status: SignUpStatus.failure,
          errorMessage:
          result.errorMessage ?? result.appError.localize(S.current),
        ));
    }
  }

  void reset() => emit(const SignUpState());
}
