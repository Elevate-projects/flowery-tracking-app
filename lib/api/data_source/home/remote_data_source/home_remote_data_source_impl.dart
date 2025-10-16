import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowery_tracking_app/api/client/api_client.dart';
import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/api/client/request_mapper.dart';
import 'package:flowery_tracking_app/api/models/order/order_model.dart';
import 'package:flowery_tracking_app/core/constants/app_collections.dart';
import 'package:flowery_tracking_app/data/data_source/home/remote_data_source/home_remote_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/accept_order/accept_order_request_entity.dart';
import 'package:flowery_tracking_app/utils/flowery_driver_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient _apiClient;
  final FirebaseFirestore _firestore;
  const HomeRemoteDataSourceImpl(this._apiClient, this._firestore);

  @override
  Future<Result<List<OrderEntity>>> fetchAllDriverPendingOrders() async {
    return executeApi(() async {
      final response = await _apiClient.fetchAllDriverPendingOrders(
        token: "Bearer ${FloweryDriverMethodHelper.currentUserToken}",
      );
      final driverOrders =
          response.orders
              ?.map((orderData) => orderData.toOrderEntity())
              .toList() ??
          <OrderEntity>[];

      return driverOrders;
    });
  }

  @override
  Future<Result<void>> acceptOrder({
    required AcceptOrderRequestEntity request,
  }) async {
    final driverData = FloweryDriverMethodHelper.driverData;
    final OrderModel orderModel = RequestMapper.orderEntityToModel(
      orderEntity: request.orderData,
    );
    return executeApi(() async {
      await _apiClient.acceptOrder(
        token: "Bearer ${FloweryDriverMethodHelper.currentUserToken}",
        orderId: request.orderId,
      );
      await _firestore
          .collection(AppCollections.orders)
          .doc(request.orderId)
          .set({
            ...orderModel.toJson(),
            "DriverName": "${driverData?.firstName} ${driverData?.lastName}",
            "DriverPhone": driverData?.phone,
            "DriverLatitude": driverData?.latitude,
            "DriverLongitude": driverData?.longitude,
            "OrderAcceptedAt": DateTime.now().toString(),
            "EstimatedArrival": DateTime.now()
                .add(const Duration(days: 3))
                .toString(),
            "PreparingYourOrderAt": "",
            "OutForDeliveryAt": "",
            "ArrivedAt": "",
            "DeliveredAt": "",
          });
    });
  }
}
