import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/order_item/order_item_entity.dart';
import 'package:flowery_tracking_app/domain/entities/product/product_entity.dart';
import 'package:flowery_tracking_app/domain/entities/shipping_address/shipping_address_entity.dart';
import 'package:flowery_tracking_app/domain/entities/store/store_entity.dart';
import 'package:flowery_tracking_app/domain/entities/user/user_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/orders/orders_repository.dart';
import 'package:flowery_tracking_app/domain/use_cases/completed_driver_orders/completed_driver_orders_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'completed_driver_orders_use_case_test.mocks.dart';

@GenerateMocks([OrdersRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockOrdersRepository mockOrdersRepository;
  late final CompletedDriverOrdersUseCase completedDriverOrdersUseCase;

  setUpAll(() {
    mockOrdersRepository = MockOrdersRepository();
    completedDriverOrdersUseCase = CompletedDriverOrdersUseCase(
      mockOrdersRepository,
    );
  });

  test(
    'when invoke() is called, it should call fetchDriverOrders() from OrdersRepository and return a List of OrderEntity',
    () async {
      // Arrange
      final List<OrderEntity> expectedOrdersEntity = [
        const OrderEntity(
          id: "order_1",
          user: UserEntity(
            id: "user_1",
            firstName: "Ahmed",
            lastName: "Tarek",
            email: "ahmed@example.com",
          ),
          orderItems: [
            OrderItemEntity(
              id: "item_1",
              product: ProductEntity(
                id: "prod_1",
                description: "A beautiful bouquet of roses",
                price: 250,
              ),
              price: 250,
              quantity: 1,
            ),
          ],
          totalPrice: 250,
          shippingAddress: ShippingAddressEntity(city: "Cairo"),
          paymentType: "Cash",
          isPaid: true,
          isDelivered: true,
          state: "Completed",
          orderNumber: "ORD-1001",
          store: StoreEntity(name: "Flowery Store", address: "Downtown Cairo"),
        ),
        const OrderEntity(
          id: "order_2",
          user: UserEntity(
            id: "user_2",
            firstName: "Mona",
            lastName: "Ali",
            email: "mona@example.com",
          ),
          orderItems: [
            OrderItemEntity(
              id: "item_2",
              product: ProductEntity(
                id: "prod_2",
                description: "A fresh mix of tulips",
                price: 400,
              ),
              price: 400,
              quantity: 2,
            ),
          ],
          totalPrice: 800,
          shippingAddress: ShippingAddressEntity(city: "Giza"),
          paymentType: "Credit Card",
          isPaid: true,
          isDelivered: true,
          state: "Completed",
          orderNumber: "ORD-1002",
          store: StoreEntity(name: "Flower Hub", address: "Mall of Egypt"),
        ),
      ];

      final expectedResult = Success<List<OrderEntity>>(expectedOrdersEntity);
      provideDummy<Result<List<OrderEntity>>>(expectedResult);

      when(
        mockOrdersRepository.fetchDriverOrders(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await completedDriverOrdersUseCase.invoke();
      final successResult = result as Success<List<OrderEntity>>;

      // Assert
      verify(mockOrdersRepository.fetchDriverOrders()).called(1);
      expect(result, isA<Success<List<OrderEntity>>>());
      expect(successResult.data.length, equals(expectedOrdersEntity.length));
      expect(
        successResult.data.first.id,
        equals(expectedOrdersEntity.first.id),
      );
      expect(
        successResult.data.first.state,
        equals(expectedOrdersEntity.first.state),
      );
      expect(
        successResult.data.first.totalPrice,
        equals(expectedOrdersEntity.first.totalPrice),
      );
      expect(
        successResult.data.first.shippingAddress?.city,
        equals(expectedOrdersEntity.first.shippingAddress?.city),
      );
      expect(
        successResult.data.first.orderItems?.first.id,
        equals(expectedOrdersEntity.first.orderItems?.first.id),
      );
    },
  );
}
