import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/config/handler/response_to_state_mapper.dart';
import 'package:tracking_app/features/profile/domain/use_cases/logout_use_case.dart';
import 'package:tracking_app/features/profile/presentation/view_model/profile_event.dart';
import 'package:tracking_app/features/profile/presentation/view_model/profile_state.dart';
import 'package:bloc/bloc.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final LogoutUseCase logoutUseCase;
  ProfileCubit({required this.logoutUseCase}) : super(ProfileState());

  void onEvent(ProfileEvent event) {
    switch (event) {
      case LogoutEvent():
        _logout();
        break;
    }
  }

  Future<void> _logout() async {
    emit(state.copyWith(logoutState: BaseState(isLoading: true)));
    final response = await logoutUseCase();

    final handler = ResponseToStateMapper.handle(response);

    emit(
      state.copyWith(
        logoutState: BaseState(
          data: handler.data,
          errorMessage: handler.errorMessage,
        ),
      ),
    );
  }
}
