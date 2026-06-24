import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/edit_profile/api/api_client/edit_profile_api_client.dart';
import 'package:tracking_app/features/edit_profile/api/datasources/edit_profile_remote_data_source_impl.dart';
import 'package:tracking_app/features/edit_profile/data/models/edit_profile_request_model.dart';
import 'package:tracking_app/features/edit_profile/data/models/edit_profile_response_model.dart';

import 'edit_profile_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([EditProfileApiClient])
void main() {
  late MockEditProfileApiClient mockApiClient;
  late EditProfileRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiClient = MockEditProfileApiClient();
    dataSource = EditProfileRemoteDataSourceImpl(mockApiClient);
  });

  // ── Helpers ────────────────────────────────────────────────────────────────

  final tRequest = EditProfileRequestModel(
    firstName: 'John',
    lastName: 'Doe',
    phone: '01234567890',
  );

  final tResponse = EditProfileResponseModel(
    message: 'success',
    driver: DriverModel(
      id: '123',
      country: 'Egypt',
      firstName: 'John',
      lastName: 'Doe',
      vehicleType: 'Car',
      vehicleNumber: '123',
      vehicleLicense: '123',
      nid: '123',
      nidImg: '123',
      email: 'john.doe@example.com',
      password: 'password',
      gender: 'male',
      phone: '01234567890',
      photo: 'photo',
      role: 'driver',
      createdAt: '2026-06-24',
    ),
  );

  // ── Test Suite ─────────────────────────────────────────────────────────────

  group('EditProfileRemoteDataSourceImpl', () {
    group('editProfile — success', () {
      test(
        'should call apiClient.editProfile with the correct request body',
        () async {
          when(mockApiClient.editProfile(any))
              .thenAnswer((_) async => tResponse);

          await dataSource.editProfile(body: tRequest);

          verify(mockApiClient.editProfile(tRequest)).called(1);
        },
      );

      test(
        'should return SuccessBaseResponse with data on successful API call',
        () async {
          when(mockApiClient.editProfile(any))
              .thenAnswer((_) async => tResponse);

          final result = await dataSource.editProfile(body: tRequest);

          expect(result, isA<SuccessBaseResponse<EditProfileResponseModel>>());
          expect((result as SuccessBaseResponse).data, equals(tResponse));
        },
      );

      test(
        'should not call apiClient more than once per editProfile call',
        () async {
          when(mockApiClient.editProfile(any))
              .thenAnswer((_) async => tResponse);

          await dataSource.editProfile(body: tRequest);

          verifyNever(mockApiClient.editProfile(argThat(isNot(tRequest))));
          verify(mockApiClient.editProfile(any)).called(1);
        },
      );
    });

    group('editProfile — failure', () {
      test(
        'should return ErrorBaseResponse when apiClient throws an Exception',
        () async {
          final tException = Exception('Server error');

          when(mockApiClient.editProfile(any)).thenThrow(tException);

          final result = await dataSource.editProfile(body: tRequest);

          expect(result, isA<ErrorBaseResponse<EditProfileResponseModel>>());
        },
      );

      test(
        'should include the error object in ErrorBaseResponse on exception',
        () async {
          final tException = Exception('Server error');

          when(mockApiClient.editProfile(any)).thenThrow(tException);

          final result = await dataSource.editProfile(body: tRequest);
          final error = result as ErrorBaseResponse<EditProfileResponseModel>;

          expect(error.error, equals(tException));
        },
      );

      test(
        'should include errorMessage as the exception toString in ErrorBaseResponse',
        () async {
          final tException = Exception('Server error');

          when(mockApiClient.editProfile(any)).thenThrow(tException);

          final result = await dataSource.editProfile(body: tRequest);
          final error = result as ErrorBaseResponse<EditProfileResponseModel>;

          expect(error.errorMessage, equals(tException.toString()));
        },
      );

      test(
        'should return ErrorBaseResponse when apiClient throws a generic error',
        () async {
          when(mockApiClient.editProfile(any))
              .thenThrow(StateError('Unexpected state'));

          final result = await dataSource.editProfile(body: tRequest);

          expect(result, isA<ErrorBaseResponse<EditProfileResponseModel>>());
        },
      );

      test(
        'should still call apiClient once even when it throws',
        () async {
          when(mockApiClient.editProfile(any)).thenThrow(Exception('fail'));

          await dataSource.editProfile(body: tRequest);

          verify(mockApiClient.editProfile(any)).called(1);
        },
      );
    });

    group('editProfile — response type integrity', () {
      test(
        'should never return SuccessBaseResponse when apiClient throws',
        () async {
          when(mockApiClient.editProfile(any)).thenThrow(Exception('fail'));

          final result = await dataSource.editProfile(body: tRequest);

          expect(
            result,
            isNot(isA<SuccessBaseResponse<EditProfileResponseModel>>()),
          );
        },
      );

      test(
        'should never return ErrorBaseResponse when apiClient succeeds',
        () async {
          when(mockApiClient.editProfile(any))
              .thenAnswer((_) async => tResponse);

          final result = await dataSource.editProfile(body: tRequest);

          expect(
            result,
            isNot(isA<ErrorBaseResponse<EditProfileResponseModel>>()),
          );
        },
      );
    });
  });
}