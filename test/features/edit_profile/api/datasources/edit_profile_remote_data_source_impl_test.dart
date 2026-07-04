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

  // Adjust the constructor/fields below to match your actual models' shape
  final requestModel = EditProfileRequestModel();
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

  group('EditProfileRemoteDataSourceImpl.editProfile', () {
    test(
      'returns SuccessBaseResponse when the apiClient returns a successful response',
      () async {
        // Arrange
        when(mockApiClient.editProfile(requestModel))
            .thenAnswer((_) async => responseModel);

        // Act
        final result = await dataSource.editProfile(body: requestModel);

        // Assert
        expect(result, isA<SuccessBaseResponse<EditProfileResponseModel>>());
        expect(
          (result as SuccessBaseResponse<EditProfileResponseModel>).data,
          responseModel,
        );
        verify(mockApiClient.editProfile(requestModel)).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );

    test(
      'returns ErrorBaseResponse when the apiClient throws an Exception',
      () async {
        // Arrange
        final exception = Exception('Something went wrong');
        when(mockApiClient.editProfile(requestModel)).thenThrow(exception);

        // Act
        final result = await dataSource.editProfile(body: requestModel);

        // Assert
        expect(result, isA<ErrorBaseResponse<EditProfileResponseModel>>());
        final errorResult =
            result as ErrorBaseResponse<EditProfileResponseModel>;
        expect(errorResult.error, exception);
        expect(errorResult.errorMessage, exception.toString());
        verify(mockApiClient.editProfile(requestModel)).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );
  });
}