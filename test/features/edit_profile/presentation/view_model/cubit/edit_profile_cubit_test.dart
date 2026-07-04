import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/config/base_state/base_state.dart';
import 'package:tracking_app/features/edit_profile/data/models/edit_profile_response_model.dart';
import 'package:tracking_app/features/edit_profile/domain/entities/edit_profile_request_entity.dart';
import 'package:tracking_app/features/edit_profile/domain/entities/edit_profile_response_entity.dart';
import 'package:tracking_app/features/edit_profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:tracking_app/features/edit_profile/presentation/view_model/cubit/edit_profile_cubit.dart';
import 'package:tracking_app/features/edit_profile/presentation/view_model/cubit/edit_profile_events.dart';
import 'package:tracking_app/features/edit_profile/presentation/view_model/cubit/edit_profile_states.dart';

import 'edit_profile_cubit_test.mocks.dart';

// Run this command after writing the file so it generates the Mock classes:
// dart run build_runner build --delete-conflicting-outputs
@GenerateMocks([EditProfileUseCase])

/// A hand-written fake that lets tests control what getImageFromSource returns
/// without relying on Mockito matchers (which have null-safety issues for
/// non-nullable parameters like ImageSource and ImagePickerOptions).
class FakeImagePickerPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements ImagePickerPlatform {
  XFile? nextResult;

  @override
  Future<XFile?> getImageFromSource({
    required ImageSource source,
    ImagePickerOptions options = const ImagePickerOptions(),
  }) async {
    return nextResult;
  }
}

void main() {
  late MockEditProfileUseCase mockUseCase;
  late FakeImagePickerPlatform fakeImagePickerPlatform;

  setUp(() {
    mockUseCase = MockEditProfileUseCase();
    fakeImagePickerPlatform = FakeImagePickerPlatform();
    ImagePickerPlatform.instance = fakeImagePickerPlatform;

    // Provide dummy so Mockito can handle BaseResponse<EditProfileResponseEntity>
    provideDummy<BaseResponse<EditProfileResponseEntity>>(
      SuccessBaseResponse<EditProfileResponseEntity>(
        data: EditProfileResponseEntity(
          message: '',
          driver: DriverEntity(
            id: '', country: '', firstName: '', lastName: '',
            vehicleType: '', vehicleNumber: '', vehicleLicense: '',
            nid: '', nidImg: '', email: '', password: '',
            gender: '', phone: '', photo: '', role: '', createdAt: '',
          ),
        ),
      ),
    );
  });

  EditProfileCubit buildCubit() => EditProfileCubit(mockUseCase);

  final requestEntity = EditProfileRequestEntity(
    firstName: 'John',
    lastName: null,
    phone: null,
    gender: null,
  );

  group('initFields', () {
    blocTest<EditProfileCubit, EditProfileStates>(
      'fills the controllers and emits the gender',
      build: buildCubit,
      act: (cubit) => cubit.initFields(
        firstName: 'John',
        lastName: 'Doe',
        phone: '01000000000',
        gender: 'male',
      ),
      verify: (cubit) {
        expect(cubit.firstNameController.text, 'John');
        expect(cubit.lastNameController.text, 'Doe');
        expect(cubit.phoneController.text, '01000000000');
        expect(cubit.state.selectedGender, 'male');
      },
    );
  });

  group('selectGender', () {
    blocTest<EditProfileCubit, EditProfileStates>(
      'emits a new state containing the selected gender',
      build: buildCubit,
      act: (cubit) => cubit.selectGender('female'),
      expect: () => [
        isA<EditProfileStates>().having(
          (s) => s.selectedGender,
          'selectedGender',
          'female',
        ),
      ],
    );
  });

  group('doIntent -> updateProfileEvent', () {
    blocTest<EditProfileCubit, EditProfileStates>(
      'does not emit any state when all fields are empty and gender is null',
      build: buildCubit,
      act: (cubit) => cubit.doIntent(EditProfileEvents.updateProfileEvent()),
      expect: () => [],
      verify: (_) {
        verifyZeroInteractions(mockUseCase);
      },
    );

    blocTest<EditProfileCubit, EditProfileStates>(
      'emits loading then success state when the use case succeeds',
      build: buildCubit,
      setUp: () {
        when(mockUseCase.call(entity: anyNamed('entity'))).thenAnswer(
          (_) async => SuccessBaseResponse<EditProfileResponseEntity>(
            data: EditProfileResponseEntity(
              message: 'success',
              driver: DriverEntity(
                id: '1',
                country: 'Egypt',
                firstName: 'John',
                lastName: 'Doe',
                vehicleType: 'Car',
                vehicleNumber: '123',
                vehicleLicense: 'license',
                nid: '12345678901234',
                nidImg: 'nid_img',
                email: 'test@example.com',
                password: 'password',
                gender: 'male',
                phone: '01234567890',
                photo: 'photo',
                role: 'driver',
                createdAt: '2026-07-04',
              ),
            ),
          ),
        );
      },
      act: (cubit) {
        cubit.firstNameController.text = 'John';
        return cubit.doIntent(EditProfileEvents.updateProfileEvent());
      },
      expect: () => [
        isA<EditProfileStates>().having(
          (s) => s.updateProfileState.isLoading,
          'isLoading',
          true,
        ),
        isA<EditProfileStates>().having(
          (s) => s.updateProfileState.isLoading,
          'isLoading',
          false,
        ),
      ],
      verify: (_) {
        verify(mockUseCase.call(entity: anyNamed('entity'))).called(1);
      },
    );

    blocTest<EditProfileCubit, EditProfileStates>(
      'emits loading then error state when the use case fails',
      build: buildCubit,
      setUp: () {
        when(mockUseCase.call(entity: anyNamed('entity'))).thenAnswer(
          (_) async => ErrorBaseResponse<EditProfileResponseEntity>(
            error: Exception('failed'),
            errorMessage: 'failed',
          ),
        );
      },
      act: (cubit) {
        cubit.firstNameController.text = 'John';
        return cubit.doIntent(EditProfileEvents.updateProfileEvent());
      },
      expect: () => [
        isA<EditProfileStates>().having(
          (s) => s.updateProfileState.isLoading,
          'isLoading',
          true,
        ),
        isA<EditProfileStates>().having(
          (s) => s.updateProfileState.isLoading,
          'isLoading',
          false,
        ),
      ],
      verify: (_) {
        verify(mockUseCase.call(entity: anyNamed('entity'))).called(1);
      },
    );
  });

  group('doIntent -> pickImageEvent', () {
    blocTest<EditProfileCubit, EditProfileStates>(
      'emits the selected image when the user picks one',
      build: buildCubit,
      setUp: () {
        fakeImagePickerPlatform.nextResult = XFile('test/path/image.jpg');
      },
      act: (cubit) => cubit.doIntent(EditProfileEvents.pickImageEvent()),
      expect: () => [
        isA<EditProfileStates>().having(
          (s) => s.selectedImagePath,
          'selectedImagePath',
          'test/path/image.jpg',
        ),
      ],
    );

    blocTest<EditProfileCubit, EditProfileStates>(
      'does not emit anything if the user cancels image selection',
      build: buildCubit,
      setUp: () {
        fakeImagePickerPlatform.nextResult = null;
      },
      act: (cubit) => cubit.doIntent(EditProfileEvents.pickImageEvent()),
      expect: () => [],
    );
  });

  group('close', () {
    test('disposes the controllers without throwing an error', () async {
      final cubit = buildCubit();
      await cubit.close();
      expect(cubit.isClosed, true);
    });
  });
}