import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/home/data/data_sources/home_remote_data_source_contract.dart';
import 'package:tracking_app/features/home/data/models/get_orders_response.dart';
import 'package:tracking_app/features/home/data/models/order_model.dart';
import 'package:tracking_app/features/home/data/models/shipping_address_model.dart';
import 'package:tracking_app/features/home/data/models/store_model.dart';
import 'package:tracking_app/features/home/data/models/user_model.dart';
import 'package:tracking_app/features/home/data/repo/home_repo_impl.dart';
import 'package:tracking_app/features/home/domain/entities/order_entity.dart';

import 'home_repo_impl_test.mocks.dart';

@GenerateMocks([HomeRemoteDataSourceContract])
void main() {
  provideDummy<BaseResponse<GetOrdersResponse>>(
    SuccessBaseResponse<GetOrdersResponse>(data: GetOrdersResponse(orders: [])),
  );

  late MockHomeRemoteDataSourceContract mockRemoteDataSource;
  late HomeRepoImpl repo;

  setUp(() {
    mockRemoteDataSource = MockHomeRemoteDataSourceContract();

    repo = HomeRepoImpl(homeRemoteDataSource: mockRemoteDataSource);
  });

  group('getPendingOrders', () {
    test(
      'should return SuccessBaseResponse<List<OrderEntity>> when datasource succeeds',
      () async {
        // Arrange
        final response = GetOrdersResponse(
          orders: [
            OrderModel(
              id: '1',
              store: StoreModel(
                name: 'Store 1',
                image: 'img',
                address: 'Cairo',
              ),
              user: UserModel(
                firstName: 'Yasser',
                lastName: 'Samir',
                photo: 'photo',
              ),
              shippingAddress: ShippingAddressModel(
                street: 'Street',
                city: 'Giza',
              ),
            ),
          ],
        );

        when(mockRemoteDataSource.getPendingOrders(page: 1)).thenAnswer(
          (_) async => SuccessBaseResponse<GetOrdersResponse>(data: response),
        );

        // Act
        final result = await repo.getPendingOrders(page: 1);

        // Assert
        expect(result, isA<SuccessBaseResponse<List<OrderEntity>>>());

        final success = result as SuccessBaseResponse<List<OrderEntity>>;

        expect(success.data.length, 1);

        expect(success.data.first.id, '1');

        expect(success.data.first.store?.name, 'Store 1');

        expect(success.data.first.user?.firstName, 'Yasser');

        verify(mockRemoteDataSource.getPendingOrders(page: 1)).called(1);

        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test('should return ErrorBaseResponse when datasource fails', () async {
      // Arrange
      final error = Exception('Server Error');

      when(mockRemoteDataSource.getPendingOrders(page: 1)).thenAnswer(
        (_) async => ErrorBaseResponse<GetOrdersResponse>(error: error),
      );

      // Act
      final result = await repo.getPendingOrders(page: 1);

      // Assert
      expect(result, isA<ErrorBaseResponse<List<OrderEntity>>>());

      final failure = result as ErrorBaseResponse<List<OrderEntity>>;

      expect(failure.error, error);

      verify(mockRemoteDataSource.getPendingOrders(page: 1)).called(1);

      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
