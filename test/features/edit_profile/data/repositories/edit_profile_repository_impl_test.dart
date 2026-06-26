import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/edit_profile/data/datasources/edit_profile_remote_data_source_contract.dart';
import 'package:tracking_app/features/edit_profile/data/models/edit_profile_response_model.dart';
import 'package:tracking_app/features/edit_profile/data/repositories/edit_profile_repository_impl.dart';
import 'package:tracking_app/features/edit_profile/domain/entities/edit_profile_request_entity.dart';
import 'package:tracking_app/features/edit_profile/domain/entities/edit_profile_response_entity.dart';

import 'edit_profile_repository_impl_test.mocks.dart';

@GenerateMocks([EditProfileRemoteDataSourceContract])
void main() {
  provideDummy<BaseResponse<EditProfileResponseModel>>(
    SuccessBaseResponse<EditProfileResponseModel>(
      data: EditProfileResponseModel(
        message: 'dummy',
        driver: DriverModel(
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

  late MockEditProfileRemoteDataSourceContract mockRemoteDataSource;
  late EditProfileRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockEditProfileRemoteDataSourceContract();
    repository = EditProfileRepositoryImpl(mockRemoteDataSource);
  });

  // ── Helpers ────────────────────────────────────────────────────────────────

  const tFirstName = 'John';
  const tLastName = 'Doe';
  const tPhone = '01234567890';

  final tResponseModel = EditProfileResponseModel(
    message: 'success',
    driver: DriverModel(
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

  Future<BaseResponse<EditProfileResponseEntity>> callRepo() =>
      repository.editProfile(
        entity: const EditProfileRequestEntity(
          firstName: tFirstName,
          lastName: tLastName,
          phone: tPhone,
        ),
      );

  // ── Test Suite ─────────────────────────────────────────────────────────────

  group('EditProfileRepositoryImpl', () {
    group('editProfile — success', () {
      setUp(() {
        when(mockRemoteDataSource.editProfile(body: anyNamed('body')))
            .thenAnswer(
          (_) async =>
              SuccessBaseResponse<EditProfileResponseModel>(data: tResponseModel),
        );
      });

      test(
        'should call remoteDataSource.editProfile with the correct request model',
        () async {
          await callRepo();

          verify(
            mockRemoteDataSource.editProfile(
              body: argThat(
                predicate<dynamic>(
                  (r) =>
                      r.firstName == tFirstName &&
                      r.lastName == tLastName &&
                      r.phone == tPhone,
                ),
                named: 'body',
              ),
            ),
          ).called(1);
        },
      );

      test(
        'should return SuccessBaseResponse<EditProfileResponseEntity> on success',
        () async {
          final result = await callRepo();

          expect(
            result,
            isA<SuccessBaseResponse<EditProfileResponseEntity>>(),
          );
        },
      );

      test(
        'should map the response model to an entity correctly',
        () async {
          final result = await callRepo();
          final entity =
              (result as SuccessBaseResponse<EditProfileResponseEntity>).data;

          expect(
            entity,
            equals(
              EditProfileResponseEntity(
                message: tResponseModel.message,
                driver: tResponseModel.driver.toDriverEntity(),
              ),
            ),
          );
        },
      );

      test(
        'should call remoteDataSource exactly once',
        () async {
          await callRepo();

          verify(mockRemoteDataSource.editProfile(body: anyNamed('body')))
              .called(1);
          verifyNoMoreInteractions(mockRemoteDataSource);
        },
      );
    });

    group('editProfile — datasource returns ErrorBaseResponse', () {
      const tErrorMessage = 'Server error';
      final tException = Exception(tErrorMessage);

      setUp(() {
        when(mockRemoteDataSource.editProfile(body: anyNamed('body')))
            .thenAnswer(
          (_) async => ErrorBaseResponse<EditProfileResponseModel>(
            error: tException,
            errorMessage: tErrorMessage,
          ),
        );
      });

      test(
        'should return ErrorBaseResponse<EditProfileResponseEntity> when datasource returns error',
        () async {
          final result = await callRepo();

          expect(
            result,
            isA<ErrorBaseResponse<EditProfileResponseEntity>>(),
          );
        },
      );

      test(
        'should use error.error when it is not null in ErrorBaseResponse',
        () async {
          final result = await callRepo();
          final error =
              result as ErrorBaseResponse<EditProfileResponseEntity>;

          expect(error.error, isA<Exception>());
        },
      );

      test(
        'should use errorMessage from exception toString when error is null',
        () async {
          when(mockRemoteDataSource.editProfile(body: anyNamed('body')))
              .thenAnswer(
            (_) async => ErrorBaseResponse<EditProfileResponseModel>(
              error: null,
              errorMessage: tErrorMessage,
            ),
          );

          final result = await callRepo();
          final error =
              result as ErrorBaseResponse<EditProfileResponseEntity>;

          expect(error.errorMessage, contains(tErrorMessage));
        },
      );
    });

    group('editProfile — datasource throws', () {
      final tException = Exception('Network failure');

      setUp(() {
        when(mockRemoteDataSource.editProfile(body: anyNamed('body')))
            .thenThrow(tException);
      });

      test(
        'should return ErrorBaseResponse when datasource throws',
        () async {
          final result = await callRepo();

          expect(
            result,
            isA<ErrorBaseResponse<EditProfileResponseEntity>>(),
          );
        },
      );

      test(
        'should capture the thrown exception in error field',
        () async {
          final result = await callRepo();
          final error =
              result as ErrorBaseResponse<EditProfileResponseEntity>;

          expect(error.error, equals(tException));
        },
      );

      test(
        'should set errorMessage to exception toString',
        () async {
          final result = await callRepo();
          final error =
              result as ErrorBaseResponse<EditProfileResponseEntity>;

          expect(error.errorMessage, equals(tException.toString()));
        },
      );
    });

    group('editProfile — response type integrity', () {
      test(
        'should never return SuccessBaseResponse when datasource returns error',
        () async {
          when(mockRemoteDataSource.editProfile(body: anyNamed('body')))
              .thenAnswer(
            (_) async => ErrorBaseResponse<EditProfileResponseModel>(
              error: Exception('fail'),
              errorMessage: 'fail',
            ),
          );

          final result = await callRepo();

          expect(
            result,
            isNot(isA<SuccessBaseResponse<EditProfileResponseEntity>>()),
          );
        },
      );

      test(
        'should never return ErrorBaseResponse when datasource succeeds',
        () async {
          when(mockRemoteDataSource.editProfile(body: anyNamed('body')))
              .thenAnswer(
            (_) async => SuccessBaseResponse<EditProfileResponseModel>(
              data: tResponseModel,
            ),
          );

          final result = await callRepo();

          expect(
            result,
            isNot(isA<ErrorBaseResponse<EditProfileResponseEntity>>()),
          );
        },
      );
    });

    group('editProfile — nullable parameters', () {
      test(
        'should handle null firstName gracefully',
        () async {
          when(mockRemoteDataSource.editProfile(body: anyNamed('body')))
              .thenAnswer(
            (_) async => SuccessBaseResponse<EditProfileResponseModel>(
              data: tResponseModel,
            ),
          );

          final result = await repository.editProfile(
            entity: const EditProfileRequestEntity(
              firstName: null,
              lastName: tLastName,
              phone: tPhone,
            ),
          );

          expect(result, isA<SuccessBaseResponse<EditProfileResponseEntity>>());
        },
      );

      test(
        'should handle all null parameters gracefully',
        () async {
          when(mockRemoteDataSource.editProfile(body: anyNamed('body')))
              .thenAnswer(
            (_) async => SuccessBaseResponse<EditProfileResponseModel>(
              data: tResponseModel,
            ),
          );

          final result = await repository.editProfile(
            entity: const EditProfileRequestEntity(
              firstName: null,
              lastName: null,
              phone: null,
            ),
          );

          expect(result, isA<SuccessBaseResponse<EditProfileResponseEntity>>());
        },
      );
    });
  });
}