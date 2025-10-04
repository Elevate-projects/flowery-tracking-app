import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/data_source/home/remote_data_source/home_remote_data_source_impl.dart';
import 'package:flowery_tracking_app/api/models/order/order_model.dart';
import 'package:flowery_tracking_app/api/models/order_item/order_item_model.dart';
import 'package:flowery_tracking_app/api/models/product/product_model.dart';
import 'package:flowery_tracking_app/api/models/shipping_address/shipping_address_model.dart';
import 'package:flowery_tracking_app/api/models/store/store_model.dart';
import 'package:flowery_tracking_app/api/models/user/user_model.dart';
import 'package:flowery_tracking_app/api/responses/driver_pending_orders/driver_pending_orders_response.dart';
import 'package:flowery_tracking_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_tracking_app/core/constants/app_collections.dart';
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

import 'home_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockApiClient mockApiClient;
  late final FakeFirebaseFirestore fakeFirestore;
  late final MockConnectivity mockedConnectivity;
  late final HomeRemoteDataSourceImpl homeRemoteDataSourceImpl;
  setUpAll(() async {
    mockApiClient = MockApiClient();
    fakeFirestore = FakeFirebaseFirestore();
    mockedConnectivity = MockConnectivity();
    homeRemoteDataSourceImpl = HomeRemoteDataSourceImpl(
      mockApiClient,
      fakeFirestore,
    );
    ConnectionManager.connectivity = mockedConnectivity;
    when(
      mockedConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);
  });
  test(
    'when call fetchAllDriverPendingOrders it should be called successfully from apiClient',
    () async {
      // Arrange
      final List<OrderModel> expectedOrdersModel = [
        OrderModel(
          id: "order_1",
          user: UserModel(
            id: "user_1",
            firstName: "Ahmed",
            lastName: "Tarek",
            email: "ahmed@example.com",
          ),
          orderItems: [
            OrderItemModel(
              id: "item_1",
              product: ProductModel(
                id: "prod_1",
                description: "A beautiful bouquet of red roses",
                price: 200,
              ),
              price: 200,
              quantity: 1,
            ),
          ],
          totalPrice: 200,
          shippingAddress: ShippingAddressModel(city: "Cairo"),
          paymentType: "Cash",
          isPaid: false,
          isDelivered: false,
          state: "Processing",
          orderNumber: "ORD-001",
          store: StoreModel(name: "Flowery Store", address: "Downtown Cairo"),
        ),
        OrderModel(
          id: "order_2",
          user: UserModel(
            id: "user_2",
            firstName: "Mona",
            lastName: "Ali",
            email: "mona@example.com",
          ),
          orderItems: [
            OrderItemModel(
              id: "item_2",
              product: ProductModel(
                id: "prod_2",
                description: "A colorful mix of tulips",
                price: 350,
              ),
              price: 350,
              quantity: 2,
            ),
          ],
          totalPrice: 700,
          shippingAddress: ShippingAddressModel(city: "Giza"),
          paymentType: "Credit Card",
          isPaid: true,
          isDelivered: true,
          state: "Delivered",
          orderNumber: "ORD-002",
          store: StoreModel(name: "Flower Hub", address: "Mall of Egypt"),
        ),
      ];
      final DriverPendingOrdersResponse expectedResponse =
          DriverPendingOrdersResponse(
            message: "success",
            orders: expectedOrdersModel,
          );
      final List<OrderEntity> expectedOrdersEntity = expectedOrdersModel
          .map((order) => order.toOrderEntity())
          .toList();
      provideDummy<DriverPendingOrdersResponse>(expectedResponse);
      when(
        mockApiClient.fetchAllDriverPendingOrders(token: anyNamed("token")),
      ).thenAnswer((_) async => expectedResponse);

      // Act
      final result = await homeRemoteDataSourceImpl
          .fetchAllDriverPendingOrders();
      final successResult = result as Success<List<OrderEntity>>;

      // assert
      verify(
        mockApiClient.fetchAllDriverPendingOrders(token: anyNamed("token")),
      ).called(1);
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
    'when call acceptOrder it should be called successfully from apiClient and the data should be saved at the firebase',
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
      provideDummy<Result<void>>(Success(null));
      when(
        mockApiClient.acceptOrder(
          token: anyNamed("token"),
          orderId: anyNamed("orderId"),
        ),
      ).thenAnswer((_) async {});

      // Act
      final result = await homeRemoteDataSourceImpl.acceptOrder(
        request: orderRequest,
      );

      // assert
      verify(
        mockApiClient.acceptOrder(
          token: anyNamed("token"),
          orderId: anyNamed("orderId"),
        ),
      ).called(1);
      final snapshot = await fakeFirestore
          .collection(AppCollections.drivers)
          .doc("order_1")
          .get();

      expect(snapshot.exists, true);
      expect(result, isA<Result<void>>());
    },
  );
}
