import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';

abstract interface class OrdersRemoteDataSource {
  Future<Result<List<OrderEntity>>> fetchDriverOrders();
}
