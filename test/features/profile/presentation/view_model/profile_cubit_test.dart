import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/profile/domain/entities/profile_data_entity.dart';
import 'package:tracking_app/features/profile/domain/use_cases/get_profile_data_use_case.dart';
import 'package:tracking_app/features/profile/domain/use_cases/logout_use_case.dart';
import 'package:tracking_app/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:tracking_app/features/profile/presentation/view_model/profile_event.dart';
import 'package:tracking_app/features/profile/presentation/view_model/profile_state.dart';
import 'profile_cubit_test.mocks.dart';

@GenerateMocks([LogoutUseCase, GetProfileDataUseCase, ProfileDataEntity])
void main() {
  setUpAll(() {
    provideDummy<BaseResponse<String>>(
      const SuccessBaseResponse<String>(data: 'dummy'),
    );
    provideDummy<BaseResponse<ProfileDataEntity>>(
      SuccessBaseResponse<ProfileDataEntity>(
        data: ProfileDataEntity(
          id: '',
          firstName: '',
          lastName: '',
          email: '',
          phone: '',
          photo: '',
        ),
      ),
    );
  });

  late MockLogoutUseCase mockLogoutUseCase;
  late MockGetProfileDataUseCase mockGetProfileDataUseCase;
  late ProfileCubit cubit;

  setUp(() {
    mockLogoutUseCase = MockLogoutUseCase();
    mockGetProfileDataUseCase = MockGetProfileDataUseCase();
    cubit = ProfileCubit(
      logoutUseCase: mockLogoutUseCase,
      getProfileDataUseCase: mockGetProfileDataUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state has non-loading, empty logout and profile states', () {
    expect(cubit.state.logoutState.isLoading, false);
    expect(cubit.state.logoutState.data, isNull);
    expect(cubit.state.logoutState.errorMessage, isNull);
    expect(cubit.state.profileDataState.isLoading, false);
    expect(cubit.state.profileDataState.data, isNull);
    expect(cubit.state.profileDataState.errorMessage, isNull);
  });

  group('LogoutEvent', () {
    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, success] logoutState when logoutUseCase succeeds',
      build: () {
        when(mockLogoutUseCase()).thenAnswer(
          (_) async => const SuccessBaseResponse<String>(
            data: 'Logged out successfully',
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(LogoutEvent()),
      expect: () => [
        predicate<ProfileState>(
          (s) =>
              s.logoutState.isLoading == true &&
              s.logoutState.data == null &&
              s.logoutState.errorMessage == null,
        ),
        predicate<ProfileState>(
          (s) =>
              s.logoutState.isLoading == false &&
              s.logoutState.data == 'Logged out successfully' &&
              s.logoutState.errorMessage == null,
        ),
      ],
      verify: (_) {
        verify(mockLogoutUseCase()).called(1);
        verifyNoMoreInteractions(mockLogoutUseCase);
        verifyZeroInteractions(mockGetProfileDataUseCase);
      },
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, error] logoutState when logoutUseCase fails',
      build: () {
        when(mockLogoutUseCase()).thenAnswer(
          (_) async => ErrorBaseResponse<String>(
            error: Exception('Network error'),
            errorMessage: 'Something went wrong',
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(LogoutEvent()),
      expect: () => [
        predicate<ProfileState>(
          (s) =>
              s.logoutState.isLoading == true &&
              s.logoutState.data == null &&
              s.logoutState.errorMessage == null,
        ),
        predicate<ProfileState>(
          (s) =>
              s.logoutState.isLoading == false &&
              s.logoutState.data == null &&
              s.logoutState.errorMessage == 'Something went wrong',
        ),
      ],
      verify: (_) {
        verify(mockLogoutUseCase()).called(1);
        verifyNoMoreInteractions(mockLogoutUseCase);
        verifyZeroInteractions(mockGetProfileDataUseCase);
      },
    );
  });

  group('LoadProfileDataEvent', () {
    final tProfileDataEntity = MockProfileDataEntity();

    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, success] profileDataState when '
      'getProfileDataUseCase succeeds',
      build: () {
        when(mockGetProfileDataUseCase()).thenAnswer(
          (_) async =>
              SuccessBaseResponse<ProfileDataEntity>(data: tProfileDataEntity),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(LoadProfileDataEvent()),
      expect: () => [
        predicate<ProfileState>(
          (s) =>
              s.profileDataState.isLoading == true &&
              s.profileDataState.data == null &&
              s.profileDataState.errorMessage == null,
        ),
        predicate<ProfileState>(
          (s) =>
              s.profileDataState.isLoading == false &&
              s.profileDataState.data == tProfileDataEntity &&
              s.profileDataState.errorMessage == null,
        ),
      ],
      verify: (_) {
        verify(mockGetProfileDataUseCase()).called(1);
        verifyNoMoreInteractions(mockGetProfileDataUseCase);
        verifyZeroInteractions(mockLogoutUseCase);
      },
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, error] profileDataState when '
      'getProfileDataUseCase fails',
      build: () {
        when(mockGetProfileDataUseCase()).thenAnswer(
          (_) async => ErrorBaseResponse<ProfileDataEntity>(
            error: Exception('Server error'),
            errorMessage: 'Unable to load profile',
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.onEvent(LoadProfileDataEvent()),
      expect: () => [
        predicate<ProfileState>(
          (s) =>
              s.profileDataState.isLoading == true &&
              s.profileDataState.data == null &&
              s.profileDataState.errorMessage == null,
        ),
        predicate<ProfileState>(
          (s) =>
              s.profileDataState.isLoading == false &&
              s.profileDataState.data == null &&
              s.profileDataState.errorMessage == 'Unable to load profile',
        ),
      ],
      verify: (_) {
        verify(mockGetProfileDataUseCase()).called(1);
        verifyNoMoreInteractions(mockGetProfileDataUseCase);
        verifyZeroInteractions(mockLogoutUseCase);
      },
    );
  });
}
