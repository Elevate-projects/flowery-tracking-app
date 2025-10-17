import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/orders/remote_data_source/orders_remote_data_source.dart';
import 'package:flowery_tracking_app/data/repositories/orders/orders_repository_impl.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_repository_impl_test.mocks.dart';

@GenerateMocks([OrdersRemoteDataSource])
void main() {
  late MockOrdersRemoteDataSource mockRemoteDataSource;
  late OrdersRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockOrdersRemoteDataSource();
    repository = OrdersRepositoryImpl(mockRemoteDataSource);
  });

  test(
    'when call fetchDriverOrders it should be called successfully from OrdersRemoteDataSource and returns a list of OrderEntity',
    () async {
      // Arrange
      final expectedOrders = [
        const OrderEntity(id: 'order_1', state: 'completed'),
        const OrderEntity(id: 'order_2', state: 'canceled'),
      ];
      final expectedResult = Success<List<OrderEntity>>(expectedOrders);
      provideDummy<Result<List<OrderEntity>>>(expectedResult);
      when(
        mockRemoteDataSource.fetchDriverOrders(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await repository.fetchDriverOrders();

      // Assert
      expect(result, isA<Success<List<OrderEntity>>>());
      final successResult = result as Success<List<OrderEntity>>;
      expect(successResult.data.length, expectedOrders.length);
      expect(successResult.data.first.id, expectedResult.data.first.id);
      expect(successResult.data.first.state, expectedResult.data.first.state);
      verify(mockRemoteDataSource.fetchDriverOrders()).called(1);
    },
  );
}
