import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/accept_order/accept_order_request_entity.dart';

abstract interface class HomeRemoteDataSource {
  Future<Result<List<OrderEntity>>> fetchAllDriverPendingOrders();
  Future<Result<void>> acceptOrder({required AcceptOrderRequestEntity request});
}
