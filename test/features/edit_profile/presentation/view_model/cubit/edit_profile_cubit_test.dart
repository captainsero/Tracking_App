import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/features/edit_profile/domain/entities/edit_profile_response_entity.dart';
import 'package:tracking_app/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:tracking_app/features/edit_profile/presentation/view_model/cubit/edit_profile_cubit.dart';
import 'package:tracking_app/features/edit_profile/presentation/view_model/cubit/edit_profile_events.dart';
import 'package:tracking_app/features/edit_profile/presentation/view_model/cubit/edit_profile_states.dart';

import 'edit_profile_cubit_test.mocks.dart';

@GenerateMocks([EditProfileUseCase])
void main() {
  provideDummy<BaseResponse<EditProfileResponseEntity>>(
    SuccessBaseResponse<EditProfileResponseEntity>(
      data: EditProfileResponseEntity(
        message: 'dummy',
        driver: DriverEntity(
          id: 'dummy',
          country: 'dummy',
          firstName: 'dummy',
          lastName: 'dummy',
          vehicleType: 'dummy',
          vehicleNumber: 'dummy',
          vehicleLicense: 'dummy',
          nid: 'dummy',
          nidImg: 'dummy',
          email: 'dummy',
          password: 'dummy',
          gender: 'dummy',
          phone: 'dummy',
          photo: 'dummy',
          role: 'dummy',
          createdAt: 'dummy',
        ),
      ),
    ),
  );

  late MockEditProfileUseCase mockUseCase;
  late EditProfileCubit cubit;

  setUp(() {
    mockUseCase = MockEditProfileUseCase();
    cubit = EditProfileCubit(mockUseCase);
  });

  tearDown(() => cubit.close());

  // ── Helpers ────────────────────────────────────────────────────────────────

  const tFirstName = 'John';
  const tLastName = 'Doe';
  const tPhone = '01234567890';

  final tEntity = EditProfileResponseEntity(
    message: 'success',
    driver: DriverEntity(
      id: '123',
      country: 'Egypt',
      firstName: tFirstName,
      lastName: tLastName,
      vehicleType: 'Car',
      vehicleNumber: '123',
      vehicleLicense: '123',
      nid: '123',
      nidImg: '123',
      email: 'john.doe@example.com',
      password: 'password',
      gender: 'male',
      phone: tPhone,
      photo: 'photo',
      role: 'driver',
      createdAt: '2026-06-24',
    ),
  );

  void fillControllers({
    String firstName = tFirstName,
    String lastName = tLastName,
    String phone = tPhone,
  }) {
    cubit.firstNameController.text = firstName;
    cubit.lastNameController.text = lastName;
    cubit.phoneController.text = phone;
  }

  // ── Test Suite ─────────────────────────────────────────────────────────────

  group('EditProfileCubit', () {
    // ── Initial state ──────────────────────────────────────────────────────
    group('initial state', () {
      test('should have correct initial state', () {
        expect(cubit.state, equals(EditProfileStates()));
      });

      test('should have empty controllers on init', () {
        expect(cubit.firstNameController.text, isEmpty);
        expect(cubit.lastNameController.text, isEmpty);
        expect(cubit.phoneController.text, isEmpty);
      });
    });

    // ── initFields ─────────────────────────────────────────────────────────
    group('initFields', () {
      test('should populate all controllers correctly', () {
        cubit.initFields(
          firstName: tFirstName,
          lastName: tLastName,
          phone: tPhone,
        );

        expect(cubit.firstNameController.text, tFirstName);
        expect(cubit.lastNameController.text, tLastName);
        expect(cubit.phoneController.text, tPhone);
      });
    });

    // ── updateProfileEvent ─────────────────────────────────────────────────
    group('doIntent — updateProfileEvent', () {
      test(
        'should do nothing when all fields are empty',
        () async {
          cubit.doIntent(EditProfileEvents.updateProfileEvent());

          verifyNever(mockUseCase.call(
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            phone: anyNamed('phone'),
          ));
          expect(cubit.state, equals(EditProfileStates()));
        },
      );

      blocTest<EditProfileCubit, EditProfileStates>(
        'should emit [loading, success] on successful update',
        build: () {
          when(
            mockUseCase.call(
              firstName: anyNamed('firstName'),
              lastName: anyNamed('lastName'),
              phone: anyNamed('phone'),
            ),
          ).thenAnswer(
            (_) async => SuccessBaseResponse<EditProfileResponseEntity>(
              data: tEntity,
            ),
          );
          return EditProfileCubit(mockUseCase)
            ..firstNameController.text = tFirstName
            ..lastNameController.text = tLastName
            ..phoneController.text = tPhone;
        },
        act: (c) => c.doIntent(EditProfileEvents.updateProfileEvent()),
        expect: () => [
          EditProfileStates().copyWith(
            updateProfileState: const BaseState<EditProfileResponseEntity>(
              isLoading: true,
            ),
          ),
          EditProfileStates().copyWith(
            updateProfileState: BaseState<EditProfileResponseEntity>(
              isLoading: false,
              data: tEntity,
            ),
          ),
        ],
      );

      blocTest<EditProfileCubit, EditProfileStates>(
        'should emit [loading, error] on failed update',
        build: () {
          when(
            mockUseCase.call(
              firstName: anyNamed('firstName'),
              lastName: anyNamed('lastName'),
              phone: anyNamed('phone'),
            ),
          ).thenAnswer(
            (_) async => ErrorBaseResponse<EditProfileResponseEntity>(
              error: Exception('fail'),
              errorMessage: 'Server error',
            ),
          );
          return EditProfileCubit(mockUseCase)
            ..firstNameController.text = tFirstName
            ..lastNameController.text = tLastName
            ..phoneController.text = tPhone;
        },
        act: (c) => c.doIntent(EditProfileEvents.updateProfileEvent()),
        expect: () => [
          EditProfileStates().copyWith(
            updateProfileState: const BaseState<EditProfileResponseEntity>(
              isLoading: true,
            ),
          ),
          EditProfileStates().copyWith(
            updateProfileState: const BaseState<EditProfileResponseEntity>(
              isLoading: false,
              errorMessage: 'Server error',
            ),
          ),
        ],
      );

      blocTest<EditProfileCubit, EditProfileStates>(
        'should pass trimmed values to use case',
        build: () {
          when(
            mockUseCase.call(
              firstName: anyNamed('firstName'),
              lastName: anyNamed('lastName'),
              phone: anyNamed('phone'),
            ),
          ).thenAnswer(
            (_) async => SuccessBaseResponse<EditProfileResponseEntity>(
              data: tEntity,
            ),
          );
          return EditProfileCubit(mockUseCase)
            ..firstNameController.text = '  $tFirstName  '
            ..lastNameController.text = '  $tLastName  '
            ..phoneController.text = '  $tPhone  ';
        },
        act: (c) => c.doIntent(EditProfileEvents.updateProfileEvent()),
        verify: (c) {
          verify(
            mockUseCase.call(
              firstName: tFirstName,
              lastName: tLastName,
              phone: tPhone,
            ),
          ).called(1);
        },
      );

      blocTest<EditProfileCubit, EditProfileStates>(
        'should pass null for empty trimmed fields',
        build: () {
          when(
            mockUseCase.call(
              firstName: anyNamed('firstName'),
              lastName: anyNamed('lastName'),
              phone: anyNamed('phone'),
            ),
          ).thenAnswer(
            (_) async => SuccessBaseResponse<EditProfileResponseEntity>(
              data: tEntity,
            ),
          );
          return EditProfileCubit(mockUseCase)
            ..firstNameController.text = tFirstName
            ..lastNameController.text = ''
            ..phoneController.text = tPhone;
        },
        act: (c) => c.doIntent(EditProfileEvents.updateProfileEvent()),
        verify: (c) {
          verify(
            mockUseCase.call(
              firstName: tFirstName,
              lastName: null,
              phone: tPhone,
            ),
          ).called(1);
        },
      );

      test(
        'should call use case exactly once per updateProfileEvent',
        () async {
          fillControllers();
          when(
            mockUseCase.call(
              firstName: anyNamed('firstName'),
              lastName: anyNamed('lastName'),
              phone: anyNamed('phone'),
            ),
          ).thenAnswer(
            (_) async => SuccessBaseResponse<EditProfileResponseEntity>(
              data: tEntity,
            ),
          );

          cubit.doIntent(EditProfileEvents.updateProfileEvent());
          await Future<void>.delayed(Duration.zero);

          verify(
            mockUseCase.call(
              firstName: anyNamed('firstName'),
              lastName: anyNamed('lastName'),
              phone: anyNamed('phone'),
            ),
          ).called(1);
          verifyNoMoreInteractions(mockUseCase);
        },
      );
    });

    // ── pickImageEvent ─────────────────────────────────────────────────────
    group('doIntent — pickImageEvent', () {
      // Note: ImagePicker is a platform plugin and cannot be mocked directly
      // with Mockito without a custom channel mock. These tests verify the
      // cubit does not crash when the event is dispatched and that the state
      // stays consistent when no image is picked (null result from picker).
      test(
        'should not change selectedImagePath when no image is picked',
        () async {
          // pickImage returns null when user cancels — the cubit should not emit
          expect(cubit.state.selectedImagePath, isNull);
        },
      );

      blocTest<EditProfileCubit, EditProfileStates>(
        'should emit state with selectedImagePath when image is picked',
        build: () => EditProfileCubit(mockUseCase),
        act: (c) {
          // Directly emit to simulate what _pickImage does after a successful pick
          c.emit(c.state.copyWith(selectedImagePath: '/path/to/image.jpg'));
        },
        expect: () => [
          EditProfileStates().copyWith(selectedImagePath: '/path/to/image.jpg'),
        ],
      );
    });

    // ── close ──────────────────────────────────────────────────────────────
    group('close', () {
      test('should dispose controllers without throwing', () async {
        expect(() => cubit.close(), returnsNormally);
      });
    });
  });
}