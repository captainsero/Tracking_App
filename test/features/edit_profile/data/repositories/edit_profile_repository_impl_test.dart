import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/edit_profile/data/datasources/edit_profile_remote_data_source_contract.dart';
import 'package:tracking_app/features/edit_profile/data/models/edit_profile_request_model.dart';
import 'package:tracking_app/features/edit_profile/data/models/edit_profile_response_model.dart';
import 'package:tracking_app/features/edit_profile/data/repositories/edit_profile_repository_impl.dart';
import 'package:tracking_app/features/edit_profile/domain/entities/edit_profile_request_entity.dart';
import 'package:tracking_app/features/edit_profile/domain/entities/edit_profile_response_entity.dart';

import 'edit_profile_repository_impl_test.mocks.dart';

@GenerateMocks([EditProfileRemoteDataSourceContract])
void main() {
  late MockEditProfileRemoteDataSourceContract mockRemoteDataSource;
  late EditProfileRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockEditProfileRemoteDataSourceContract();
    repository = EditProfileRepositoryImpl(mockRemoteDataSource);

    // Provide dummy so Mockito can handle BaseResponse<EditProfileResponseModel>
    provideDummy<BaseResponse<EditProfileResponseModel>>(
      SuccessBaseResponse<EditProfileResponseModel>(
        data: EditProfileResponseModel(
          message: '',
          driver: DriverModel(
            id: '',
            country: '',
            firstName: '',
            lastName: '',
            vehicleType: '',
            vehicleNumber: '',
            vehicleLicense: '',
            nid: '',
            nidImg: '',
            email: '',
            password: '',
            gender: '',
            phone: '',
            photo: '',
            role: '',
            createdAt: '',
          ),
        ),
      ),
    );
  });

  // Adjust the constructors below to match the actual fields in your project
  final requestEntity = EditProfileRequestEntity(
    firstName: 'John',
    lastName: 'Doe',
    phone: '01000000000',
    gender: 'male',
  );

  final requestModel = EditProfileRequestModel(
    firstName: requestEntity.firstName,
    lastName: requestEntity.lastName,
    phone: requestEntity.phone,
    gender: requestEntity.gender,
  );

  group('EditProfileRepositoryImpl.editProfile', () {
    test(
      'returns SuccessBaseResponse<EditProfileResponseEntity> when the data source succeeds',
      () async {
        // Arrange
        final responseModel = EditProfileResponseModel(
          message: 'Success',
          driver: DriverModel(
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
        );

        when(mockRemoteDataSource.editProfile(body: anyNamed('body'))).thenAnswer(
          (_) async => SuccessBaseResponse<EditProfileResponseModel>(
            data: responseModel,
          ),
        );

        // Act
        final result = await repository.editProfile(entity: requestEntity);

        // Assert
        expect(result, isA<SuccessBaseResponse<EditProfileResponseEntity>>());
        verify(mockRemoteDataSource.editProfile(body: anyNamed('body'))).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'returns ErrorBaseResponse<EditProfileResponseEntity> when the data source returns ErrorBaseResponse',
      () async {
        // Arrange
        final exception = Exception('server error');

        when(mockRemoteDataSource.editProfile(body: anyNamed('body'))).thenAnswer(
          (_) async => ErrorBaseResponse<EditProfileResponseModel>(
            error: exception,
            errorMessage: exception.toString(),
          ),
        );

        // Act
        final result = await repository.editProfile(entity: requestEntity);

        // Assert
        expect(result, isA<ErrorBaseResponse<EditProfileResponseEntity>>());
        final errorResult = result as ErrorBaseResponse<EditProfileResponseEntity>;
        expect(errorResult.error, exception);
        expect(errorResult.errorMessage, exception.toString());
        verify(mockRemoteDataSource.editProfile(body: anyNamed('body'))).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'returns ErrorBaseResponse<EditProfileResponseEntity> when the data source throws an Exception directly',
      () async {
        // Arrange
        final exception = Exception('network error');

        when(mockRemoteDataSource.editProfile(body: anyNamed('body')))
            .thenThrow(exception);

        // Act
        final result = await repository.editProfile(entity: requestEntity);

        // Assert
        expect(result, isA<ErrorBaseResponse<EditProfileResponseEntity>>());
        final errorResult = result as ErrorBaseResponse<EditProfileResponseEntity>;
        expect(errorResult.error, exception);
        expect(errorResult.errorMessage, exception.toString());
        verify(mockRemoteDataSource.editProfile(body: anyNamed('body'))).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );
  });
}