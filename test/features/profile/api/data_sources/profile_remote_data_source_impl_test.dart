import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/profile/api/api_client/profile_api_client.dart';
import 'package:tracking_app/features/profile/api/data_sources/profile_remote_data_source_impl.dart';
import 'package:tracking_app/features/profile/data/models/profile_data_model.dart';

// Run `dart run build_runner build --delete-conflicting-outputs`
// (or `flutter pub run build_runner build ...`) to generate
// profile_remote_data_source_impl_test.mocks.dart
import 'profile_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ProfileApiClient, ProfileDataModel])
void main() {
  late MockProfileApiClient mockApiClient;
  late ProfileRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiClient = MockProfileApiClient();
    dataSource = ProfileRemoteDataSourceImpl(apiClient: mockApiClient);
  });

  group('getProfileData', () {
    final tProfileDataModel = MockProfileDataModel();

    test(
      'should return SuccessBaseResponse with the data when the call to '
      'apiClient.getProfileData() succeeds',
      () async {
        // arrange
        when(mockApiClient.getProfileData())
            .thenAnswer((_) async => tProfileDataModel);

        // act
        final result = await dataSource.getProfileData();

        // assert
        expect(result, isA<SuccessBaseResponse<ProfileDataModel>>());
        expect(
          (result as SuccessBaseResponse<ProfileDataModel>).data,
          tProfileDataModel,
        );
        verify(mockApiClient.getProfileData()).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );

    test(
      'should return ErrorBaseResponse with the error when the call to '
      'apiClient.getProfileData() throws',
      () async {
        // arrange
        final tException = Exception('Something went wrong');
        when(mockApiClient.getProfileData()).thenThrow(tException);

        // act
        final result = await dataSource.getProfileData();

        // assert
        expect(result, isA<ErrorBaseResponse<ProfileDataModel>>());
        expect(
          (result as ErrorBaseResponse<ProfileDataModel>).error,
          tException,
        );
        verify(mockApiClient.getProfileData()).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );
  });

  group('logout', () {
    const tLogoutMessage = 'Logged out successfully';

    test(
      'should return SuccessBaseResponse<String> when the call to '
      'apiClient.logout() succeeds',
      () async {
        // arrange
        when(mockApiClient.logout())
            .thenAnswer((_) async => tLogoutMessage);

        // act
        final result = await dataSource.logout();

        // assert
        expect(result, isA<SuccessBaseResponse<String>>());
        expect(
          (result as SuccessBaseResponse<String>).data,
          tLogoutMessage,
        );
        verify(mockApiClient.logout()).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );

    test(
      'should return ErrorBaseResponse<String> when the call to '
      'apiClient.logout() throws',
      () async {
        // arrange
        final tException = Exception('Logout failed');
        when(mockApiClient.logout()).thenThrow(tException);

        // act
        final result = await dataSource.logout();

        // assert
        expect(result, isA<ErrorBaseResponse<String>>());
        expect(
          (result as ErrorBaseResponse<String>).error,
          tException,
        );
        verify(mockApiClient.logout()).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );
  });
}