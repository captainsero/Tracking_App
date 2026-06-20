import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/profile/api/api_client/profile_api_client.dart';
import 'package:tracking_app/features/profile/api/data_sources/profile_remote_data_source_impl.dart';

import 'profile_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ProfileApiClient])
void main() {
  late MockProfileApiClient mockApiClient;
  late ProfileRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockApiClient = MockProfileApiClient();

    remoteDataSource = ProfileRemoteDataSourceImpl(apiClient: mockApiClient);
  });

  group('logout', () {
    test('should return SuccessBaseResponse when api succeeds', () async {
      // Arrange
      when(mockApiClient.logout()).thenAnswer((_) async => 'Logged out');

      // Act
      final result = await remoteDataSource.logout();

      // Assert
      expect(result, isA<SuccessBaseResponse<String>>());

      final success = result as SuccessBaseResponse<String>;

      expect(success.data, 'Logged out');

      verify(mockApiClient.logout()).called(1);

      verifyNoMoreInteractions(mockApiClient);
    });

    test('should return ErrorBaseResponse when api throws', () async {
      // Arrange
      when(mockApiClient.logout()).thenThrow(Exception('Server Error'));

      // Act
      final result = await remoteDataSource.logout();

      // Assert
      expect(result, isA<ErrorBaseResponse<String>>());

      verify(mockApiClient.logout()).called(1);

      verifyNoMoreInteractions(mockApiClient);
    });
  });
}
