import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/order_details/update_order_status_request_entity.dart';

abstract interface class OrderDetailsRemoteDataSource {
  Future<Result<String?>> fetchAllDriverOrders();
  Stream<Result<OrderEntity>> fetchCurrentDriverOrder({
    required String orderId,
  });
  Future<Result<void>> updateCurrentDriverOrderStatus({
    required UpdateOrderStatusRequestEntity request,
  });
}
