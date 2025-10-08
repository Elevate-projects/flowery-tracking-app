import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/data_source/order_details/remote_data_source/order_details_remote_data_source_impl.dart';
import 'package:flowery_tracking_app/api/models/driver_order/driver_order_model.dart';
import 'package:flowery_tracking_app/api/models/order/order_model.dart';
import 'package:flowery_tracking_app/api/responses/all_driver_orders/all_driver_orders_response.dart';
import 'package:flowery_tracking_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_tracking_app/core/constants/app_collections.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/order_details/update_order_status_request_entity.dart';
import 'package:flowery_tracking_app/domain/entities/user/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'order_details_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockApiClient mockApiClient;
  late final FakeFirebaseFirestore fakeFirestore;
  late final MockConnectivity mockedConnectivity;
  late final OrderDetailsRemoteDataSourceImpl orderDetailsRemoteDataSourceImpl;
  setUpAll(() async {
    mockApiClient = MockApiClient();
    fakeFirestore = FakeFirebaseFirestore();
    mockedConnectivity = MockConnectivity();
    orderDetailsRemoteDataSourceImpl = OrderDetailsRemoteDataSourceImpl(
      mockApiClient,
      fakeFirestore,
    );
    ConnectionManager.connectivity = mockedConnectivity;
    when(
      mockedConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);
  });
  test(
    'when call fetchAllDriverOrders it should be called successfully from apiClient and returns the selected order',
    () async {
      // Arrange
      final AllDriverOrdersResponse expectedResponse = AllDriverOrdersResponse(
        orders: [
          DriverOrderModel(
            order: OrderModel(id: "1234", state: "completed"),
          ),
          DriverOrderModel(
            order: OrderModel(id: "12345", state: "inProgress"),
          ),
        ],
      );
      final expectedResult = Success("12345");
      provideDummy<Result<String?>>(expectedResult);
      when(
        mockApiClient.fetchAllDriverOrders(token: anyNamed("token")),
      ).thenAnswer((_) async => expectedResponse);

      // Act
      final result = await orderDetailsRemoteDataSourceImpl
          .fetchAllDriverOrders();

      // assert
      verify(
        mockApiClient.fetchAllDriverOrders(token: anyNamed("token")),
      ).called(1);
      expect(result, isA<Success<String?>>());
      final successResult = result as Success<String?>;
      expect(expectedResult.data, equals(successResult.data));
    },
  );

  test(
    'when call fetchCurrentDriverOrder it should be called successfully from FirebaseFirestore and returns the selected order data',
    () async {
      // Arrange
      final orderId = "12345";

      final orderJson = {
        "_id": orderId,
        "state": "inProgress",
        "paymentType": "cash",
        "totalPrice": 3560,
        "user": {"firstName": "Ahmed", "lastName": "Tarek"},
      };

      await fakeFirestore
          .collection(AppCollections.orders)
          .doc(orderId)
          .set(orderJson);

      final expectedResult = const OrderEntity(
        id: "12345",
        state: "inProgress",
        paymentType: "cash",
        totalPrice: 3560,
        user: UserEntity(firstName: "Ahmed", lastName: "Tarek"),
      );

      // Act
      final result = await orderDetailsRemoteDataSourceImpl
          .fetchCurrentDriverOrder(orderId: orderId);

      // Assert
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
    'when call updateOrderStatus it should be called successfully from apiClient and update firestore state value',
    () async {
      // Arrange
      const request = UpdateOrderStatusRequestEntity(
        orderId: "1234",
        orderStatus: "completed",
      );

      provideDummy<Result<void>>(Success(null));

      when(
        mockApiClient.updateOrderStatus(
          orderId: anyNamed("orderId"),
          token: anyNamed("token"),
          request: anyNamed("request"),
        ),
      ).thenAnswer((_) async {});

      await fakeFirestore
          .collection(AppCollections.orders)
          .doc(request.orderId)
          .set({"state": "inProgress"});

      // Act
      final result = await orderDetailsRemoteDataSourceImpl
          .updateCurrentDriverOrderStatus(request: request);

      // Assert
      expect(result, isA<Success<void>>());
      verify(
        mockApiClient.updateOrderStatus(
          orderId: anyNamed("orderId"),
          token: anyNamed("token"),
          request: anyNamed("request"),
        ),
      ).called(1);

      final updatedDoc = await fakeFirestore
          .collection(AppCollections.orders)
          .doc(request.orderId)
          .get();

      expect(updatedDoc.data()?['state'], equals(request.orderStatus));
    },
  );
}
