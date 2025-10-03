import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/home/remote_data_source/home_remote_data_source.dart';
import 'package:flowery_tracking_app/data/repositories/home/home_repository_impl.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/order_item/order_item_entity.dart';
import 'package:flowery_tracking_app/domain/entities/product/product_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/accept_order/accept_order_request_entity.dart';
import 'package:flowery_tracking_app/domain/entities/shipping_address/shipping_address_entity.dart';
import 'package:flowery_tracking_app/domain/entities/store/store_entity.dart';
import 'package:flowery_tracking_app/domain/entities/user/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repository_impl_test.mocks.dart';

@GenerateMocks([HomeRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockHomeRemoteDataSource mockHomeRemoteDataSource;
  late final HomeRepositoryImpl homeRepositoryImpl;
  setUpAll(() {
    mockHomeRemoteDataSource = MockHomeRemoteDataSource();
    homeRepositoryImpl = HomeRepositoryImpl(mockHomeRemoteDataSource);
  });
  test(
    'when call fetchAllDriverPendingOrders it should be called successfully from HomeRemoteDataSource and returns a List of OrderEntity',
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
                description: "A beautiful bouquet of red roses",
                price: 200,
              ),
              price: 200,
              quantity: 1,
            ),
          ],
          totalPrice: 200,
          shippingAddress: ShippingAddressEntity(city: "Cairo"),
          paymentType: "Cash",
          isPaid: false,
          isDelivered: false,
          state: "Processing",
          orderNumber: "ORD-001",
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
                description: "A colorful mix of tulips",
                price: 350,
              ),
              price: 350,
              quantity: 2,
            ),
          ],
          totalPrice: 700,
          shippingAddress: ShippingAddressEntity(city: "Giza"),
          paymentType: "Credit Card",
          isPaid: true,
          isDelivered: true,
          state: "Delivered",
          orderNumber: "ORD-002",
          store: StoreEntity(name: "Flower Hub", address: "Mall of Egypt"),
        ),
      ];
      final expectedResult = Success<List<OrderEntity>>(expectedOrdersEntity);
      provideDummy<Result<List<OrderEntity>>>(expectedResult);
      when(
        mockHomeRemoteDataSource.fetchAllDriverPendingOrders(),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await homeRepositoryImpl.fetchAllDriverPendingOrders();
      final successResult = result as Success<List<OrderEntity>>;

      // Assert
      verify(mockHomeRemoteDataSource.fetchAllDriverPendingOrders()).called(1);
      expect(result, isA<Success<List<OrderEntity>>>());
      expect(
        successResult.data.elementAt(0).id,
        equals(expectedOrdersEntity.elementAt(0).id),
      );
      expect(
        successResult.data.elementAt(0).state,
        equals(expectedOrdersEntity.elementAt(0).state),
      );
      expect(
        successResult.data.elementAt(0).totalPrice,
        equals(expectedOrdersEntity.elementAt(0).totalPrice),
      );
      expect(
        successResult.data.elementAt(0).shippingAddress?.city,
        equals(expectedOrdersEntity.elementAt(0).shippingAddress?.city),
      );
      expect(
        successResult.data.elementAt(0).orderItems?.elementAt(0).id,
        equals(expectedOrdersEntity.elementAt(0).orderItems?.elementAt(0).id),
      );
    },
  );

  test(
    'when call acceptOrder it should be called successfully from HomeRemoteDataSource',
    () async {
      // Arrange
      final AcceptOrderRequestEntity orderRequest =
          const AcceptOrderRequestEntity(
            orderId: "order_1",
            orderData: OrderEntity(
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
                    description: "A beautiful bouquet of red roses",
                    price: 200,
                  ),
                  price: 200,
                  quantity: 1,
                ),
              ],
              totalPrice: 200,
              shippingAddress: ShippingAddressEntity(city: "Cairo"),
              paymentType: "Cash",
              isPaid: false,
              isDelivered: false,
              state: "Processing",
              orderNumber: "ORD-001",
              store: StoreEntity(
                name: "Flowery Store",
                address: "Downtown Cairo",
              ),
            ),
          );
      final expectedResult = Success<void>(null);
      provideDummy<Result<void>>(expectedResult);
      when(
        mockHomeRemoteDataSource.acceptOrder(request: anyNamed("request")),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await homeRepositoryImpl.acceptOrder(
        request: orderRequest,
      );

      // Assert
      verify(
        mockHomeRemoteDataSource.acceptOrder(request: anyNamed("request")),
      ).called(1);
      expect(result, isA<Success<void>>());
    },
  );
}
