import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/config/handler/response_to_state_mapper.dart';
import 'package:tracking_app/features/profile/domain/use_cases/get_profile_data_use_case.dart';
import 'package:tracking_app/features/profile/domain/use_cases/logout_use_case.dart';
import 'package:tracking_app/features/profile/presentation/view_model/profile_event.dart';
import 'package:tracking_app/features/profile/presentation/view_model/profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final LogoutUseCase logoutUseCase;
  final GetProfileDataUseCase getProfileDataUseCase;

  ProfileCubit({
    required this.logoutUseCase,
    required this.getProfileDataUseCase,
  }) : super(const ProfileState());

  void onEvent(ProfileEvent event) {
    switch (event) {
      case LogoutEvent():
        _logout();
        break;
      case LoadProfileDataEvent():
        _loadProfileData();
        break;
    }
  }

  Future<void> _logout() async {
    emit(state.copyWith(logoutState: const BaseState(isLoading: true)));
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

  Future<void> _loadProfileData() async {
    emit(state.copyWith(profileDataState: const BaseState(isLoading: true)));
    final response = await getProfileDataUseCase();

    final handler = ResponseToStateMapper.handle(response);

    emit(
      state.copyWith(
        profileDataState: BaseState(
          data: handler.data,
          errorMessage: handler.errorMessage,
        ),
      ),
    );
  }
}