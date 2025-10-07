import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/data_source/orders/remote_data_source/orders_remote_data_source_impl.dart';
import 'package:flowery_tracking_app/api/models/driver_order/driver_order_model.dart';
import 'package:flowery_tracking_app/api/models/order/order_model.dart';
import 'package:flowery_tracking_app/api/responses/all_driver_orders/all_driver_orders_response.dart';
import 'package:flowery_tracking_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_tracking_app/core/constants/app_collections.dart';
import 'package:flowery_tracking_app/core/constants/const_keys.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'orders_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockApiClient mockApiClient;
  late final FakeFirebaseFirestore fakeFirestore;
  late final MockConnectivity mockedConnectivity;
  late final OrdersRemoteDataSourceImpl ordersRemoteDataSourceImpl;
  setUpAll(() async {
    mockApiClient = MockApiClient();
    fakeFirestore = FakeFirebaseFirestore();
    mockedConnectivity = MockConnectivity();
    ordersRemoteDataSourceImpl = OrdersRemoteDataSourceImpl(
      mockApiClient,
      fakeFirestore,
    );
    ConnectionManager.connectivity = mockedConnectivity;
    when(
      mockedConnectivity.checkConnectivity(),
    ).thenAnswer((_) async => [ConnectivityResult.wifi]);
  });
  test(
    'when call fetchAllDriverOrders it should be called successfully from apiClient and fetchDriverOrders should returns a list of OrderEntity',
    () async {
      // Arrange
      final List<OrderModel> expectedOrdersModel = [
        OrderModel(id: "order_1", state: ConstKeys.completed),
        OrderModel(id: "order_2", state: ConstKeys.canceled),
      ];
      final AllDriverOrdersResponse expectedResponse = AllDriverOrdersResponse(
        orders: [
          DriverOrderModel(order: expectedOrdersModel[0]),
          DriverOrderModel(order: expectedOrdersModel[1]),
        ],
      );
      final List<OrderEntity> expectedOrdersEntity = expectedOrdersModel
          .map((order) => order.toOrderEntity())
          .toList();
      provideDummy<AllDriverOrdersResponse>(expectedResponse);
      when(
        mockApiClient.fetchAllDriverOrders(token: anyNamed("token")),
      ).thenAnswer((_) async => expectedResponse);
      await fakeFirestore
          .collection(AppCollections.orders)
          .doc(expectedOrdersModel.first.id)
          .set(expectedOrdersModel.first.toJson());
      await fakeFirestore
          .collection(AppCollections.orders)
          .doc(expectedOrdersModel.last.id)
          .set(expectedOrdersModel.last.toJson());

      // Act
      final result = await ordersRemoteDataSourceImpl.fetchDriverOrders();

      // assert
      verify(
        mockApiClient.fetchAllDriverOrders(token: anyNamed("token")),
      ).called(1);
      expect(result, isA<Success<List<OrderEntity>>>());
      final successDocResult = await fakeFirestore
          .collection(AppCollections.orders)
          .where(
            FieldPath.documentId,
            whereIn: [
              expectedOrdersModel.first.id,
              expectedOrdersModel.last.id,
            ],
          )
          .get();
      final successOrdersResult = successDocResult.docs
          .map((doc) => OrderModel.fromJson(doc.data()).toOrderEntity())
          .toList();
      expect(
        successOrdersResult.elementAt(0).id,
        equals(expectedOrdersEntity.elementAt(0).id),
      );
      expect(
        successOrdersResult.elementAt(0).state,
        equals(expectedOrdersEntity.elementAt(0).state),
      );
    },
  );
}
