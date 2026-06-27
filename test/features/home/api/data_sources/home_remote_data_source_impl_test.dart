import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/home/api/api_client/home_api_client.dart';
import 'package:tracking_app/features/home/api/data_sources/home_remote_data_source_impl.dart';
import 'package:tracking_app/features/home/data/models/get_orders_response.dart';

import 'home_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([HomeApiClient])
void main() {
  late MockHomeApiClient mockApiClient;
  late HomeRemoteDataSourceImpl remoteDataSource;

  setUp(() {
    mockApiClient = MockHomeApiClient();

    remoteDataSource = HomeRemoteDataSourceImpl(apiClient: mockApiClient);
  });

  group('getPendingOrders', () {
    test('should return SuccessBaseResponse when api succeeds', () async {
      // Arrange
      final apiResponse = GetOrdersResponse(orders: []);

      when(
        mockApiClient.getPendingOrders(page: 1),
      ).thenAnswer((_) async => apiResponse);

      // Act
      final result = await remoteDataSource.getPendingOrders(page: 1);

      // Assert
      expect(result, isA<SuccessBaseResponse<GetOrdersResponse>>());

      final success = result as SuccessBaseResponse<GetOrdersResponse>;

      expect(success.data, apiResponse);

      verify(mockApiClient.getPendingOrders(page: 1)).called(1);

      verifyNoMoreInteractions(mockApiClient);
    });

    test('should return ErrorBaseResponse when api throws', () async {
      // Arrange
      final exception = Exception('Server Error');

      when(mockApiClient.getPendingOrders(page: 1)).thenThrow(exception);

      // Act
      final result = await remoteDataSource.getPendingOrders(page: 1);

      // Assert
      expect(result, isA<ErrorBaseResponse<GetOrdersResponse>>());

      final failure = result as ErrorBaseResponse<GetOrdersResponse>;

      expect(failure.error, exception);

      verify(mockApiClient.getPendingOrders(page: 1)).called(1);

      verifyNoMoreInteractions(mockApiClient);
    });
  });
}
