import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/client/request_mapper.dart';
import 'package:flowery_tracking_app/api/models/driver_order/driver_order_model.dart';
import 'package:flowery_tracking_app/api/models/order/order_model.dart';
import 'package:flowery_tracking_app/core/constants/app_collections.dart';
import 'package:flowery_tracking_app/data/data_source/order_details/remote_data_source/order_details_remote_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/order_details/update_order_status_request_entity.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderDetailsRemoteDataSource)
class OrderDetailsRemoteDataSourceImpl implements OrderDetailsRemoteDataSource {
  final ApiClient _apiClient;
  final FirebaseFirestore _firestore;
  const OrderDetailsRemoteDataSourceImpl(this._apiClient, this._firestore);

  @override
  Future<Result<String?>> fetchAllDriverOrders() async {
    return await executeApi(() async {
      final result = await _apiClient.fetchAllDriverOrders(
        token: "Bearer ${FloweryDriverMethodHelper.currentUserToken}",
      );
      final currentOrderId = result.orders
          ?.firstWhere(
            (orderData) =>
                orderData.order?.state == CurrentOrderState.inProgress.name,
            orElse: () => DriverOrderModel.empty(),
          )
          .order
          ?.id;
      return currentOrderId;
    });
  }

  @override
  Future<Result<OrderEntity>> fetchCurrentDriverOrder({
    required String orderId,
  }) {
    return executeApi(() async {
      final orderSnapshot = await _firestore
          .collection(AppCollections.drivers)
          .doc(orderId)
          .get();
      final orderData = OrderModel.fromJson(orderSnapshot.data()!);
      return orderData.toOrderEntity();
    });
  }

  @override
  Future<Result<void>> updateCurrentDriverOrderStatus({
    required UpdateOrderStatusRequestEntity request,
  }) {
    return executeApi(() async {
      await _apiClient.updateOrderStatus(
        orderId: request.orderId,
        token: "Bearer ${FloweryDriverMethodHelper.currentUserToken}",
        request: RequestMapper.toUpdateOrderStatusRequestModel(
          updateOrderStatusRequestEntity: request,
        ),
      );
      await _firestore
          .collection(AppCollections.drivers)
          .doc(request.orderId)
          .update({"state": request.orderStatus});
    });
  }
}
