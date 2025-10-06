import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/order_details/remote_data_source/order_details_remote_data_source.dart';
import 'package:flowery_tracking_app/data/repositories/order_details/order_details_repository_impl.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/order_details/update_order_status_request_entity.dart';
import 'package:flowery_tracking_app/domain/entities/user/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_details_repository_impl_test.mocks.dart';

@GenerateMocks([OrderDetailsRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockOrderDetailsRemoteDataSource mockOrderDetailsRemoteDataSource;
  late final OrderDetailsRepositoryImpl orderDetailsRepositoryImpl;
  setUpAll(() {
    mockOrderDetailsRemoteDataSource = MockOrderDetailsRemoteDataSource();
    orderDetailsRepositoryImpl = OrderDetailsRepositoryImpl(
      mockOrderDetailsRemoteDataSource,
    );
  });
  test(
    'when call fetchAllDriverOrders it should be called successfully from OrderDetailsRemoteDataSource and returns the order Id',
    () async {
      // Arrange
      final expectedResult = Success("12345");
      provideDummy<Result<String?>>(expectedResult);

      when(
        mockOrderDetailsRemoteDataSource.fetchAllDriverOrders(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await orderDetailsRepositoryImpl.fetchAllDriverOrders();

      // Assert
      verify(mockOrderDetailsRemoteDataSource.fetchAllDriverOrders()).called(1);
      expect(result, isA<Success<String?>>());
      final successResult = result as Success<String?>;
      expect(successResult.data, equals(expectedResult.data));
    },
  );

  test(
    'when call fetchCurrentDriverOrder it should be called successfully from OrderDetailsRemoteDataSource and returns the order Data',
    () async {
      // Arrange
      final String orderId = "12345";
      final expectedResult = OrderEntity(
        id: orderId,
        state: "inProgress",
        paymentType: "cash",
        totalPrice: 3560,
        user: const UserEntity(firstName: "Ahmed", lastName: "Tarek"),
      );
      final expectedSuccessResult = Success(expectedResult);
      provideDummy<Result<OrderEntity>>(expectedSuccessResult);

      when(
        mockOrderDetailsRemoteDataSource.fetchCurrentDriverOrder(
          orderId: anyNamed("orderId"),
        ),
      ).thenAnswer((_) async => expectedSuccessResult);

      // Act
      final result = await orderDetailsRepositoryImpl.fetchCurrentDriverOrder(
        orderId: orderId,
      );

      // Assert
      verify(
        mockOrderDetailsRemoteDataSource.fetchCurrentDriverOrder(
          orderId: anyNamed("orderId"),
        ),
      ).called(1);
      expect(result, isA<Success<OrderEntity>>());
      final successResult = result as Success<OrderEntity>;
      expect(successResult.data.id, equals(expectedResult.id));
      expect(successResult.data.state, equals(expectedResult.state));
      expect(
        successResult.data.paymentType,
        equals(expectedResult.paymentType),
      );
      expect(successResult.data.totalPrice, equals(expectedResult.totalPrice));
      expect(
        successResult.data.user?.firstName,
        equals(expectedResult.user?.firstName),
      );
      expect(
        successResult.data.user?.lastName,
        equals(expectedResult.user?.lastName),
      );
    },
  );

  test(
    'when call updateCurrentDriverOrderStatus it should be called successfully from OrderDetailsRemoteDataSource',
    () async {
      // Arrange
      const request = UpdateOrderStatusRequestEntity(
        orderId: "1234",
        orderStatus: "completed",
      );
      final expectedResult = Success<void>(null);
      provideDummy<Result<void>>(expectedResult);

      when(
        mockOrderDetailsRemoteDataSource.updateCurrentDriverOrderStatus(
          request: anyNamed("request"),
        ),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await orderDetailsRepositoryImpl
          .updateCurrentDriverOrderStatus(request: request);

      // Assert
      verify(
        mockOrderDetailsRemoteDataSource.updateCurrentDriverOrderStatus(
          request: anyNamed("request"),
        ),
      ).called(1);
      expect(result, isA<Success<void>>());
    },
  );
}
