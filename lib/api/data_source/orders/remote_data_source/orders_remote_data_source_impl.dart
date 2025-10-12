import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/models/order/order_model.dart';
import 'package:flowery_tracking_app/core/constants/app_collections.dart';
import 'package:flowery_tracking_app/core/constants/const_keys.dart';
import 'package:flowery_tracking_app/data/data_source/orders/remote_data_source/orders_remote_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrdersRemoteDataSource)
class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final ApiClient _apiClient;
  final FirebaseFirestore _firestore;
  const OrdersRemoteDataSourceImpl(this._apiClient, this._firestore);

  @override
  Future<Result<List<OrderEntity>>> fetchDriverOrders() async {
    return executeApi(() async {
      List<OrderEntity> ordersList = [];
      final response = await _apiClient.fetchAllDriverOrders(
        token: "Bearer ${FloweryDriverMethodHelper.currentUserToken}",
      );
      final neededOrders = response.orders
          ?.where(
            (orderData) =>
                orderData.order?.state?.trim() == ConstKeys.completed ||
                orderData.order?.state?.trim() == ConstKeys.canceled,
          )
          .toList();
      final neededOrdersIds = neededOrders
          ?.map((orderData) => orderData.order?.id)
          .toList();

      if (neededOrdersIds != null && neededOrdersIds.isNotEmpty) {
        final chunks = <List<String?>>[];
        for (int i = 0; i < neededOrdersIds.length; i += 10) {
          chunks.add(
            neededOrdersIds.sublist(
              i,
              i + 10 > neededOrdersIds.length ? neededOrdersIds.length : i + 10,
            ),
          );
        }

        final List<QueryDocumentSnapshot> allDocs = [];

        for (final chunk in chunks) {
          final snapshot = await _firestore
              .collection(AppCollections.orders)
              .where(FieldPath.documentId, whereIn: chunk)
              .get();
          allDocs.addAll(snapshot.docs);
        }
        ordersList = allDocs
            .map(
              (doc) => OrderModel.fromJson(
                doc.data() as Map<String, dynamic>,
              ).toOrderEntity(),
            )
            .toList();
      }

      return ordersList;
    });
  }
}
