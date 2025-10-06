import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/order_details/remote_data_source/order_details_remote_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/order_details/update_order_status_request_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/order_details/order_details_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderDetailsRepository)
class OrderDetailsRepositoryImpl implements OrderDetailsRepository {
  final OrderDetailsRemoteDataSource _orderDetailsRemoteDataSource;
  const OrderDetailsRepositoryImpl(this._orderDetailsRemoteDataSource);

  @override
  Future<Result<String?>> fetchAllDriverOrders() async {
    return await _orderDetailsRemoteDataSource.fetchAllDriverOrders();
  }

  @override
  Future<Result<OrderEntity>> fetchCurrentDriverOrder({
    required String orderId,
  }) async {
    return await _orderDetailsRemoteDataSource.fetchCurrentDriverOrder(
      orderId: orderId,
    );
  }

  @override
  Future<Result<void>> updateCurrentDriverOrderStatus({
    required UpdateOrderStatusRequestEntity request,
  }) async {
    return await _orderDetailsRemoteDataSource.updateCurrentDriverOrderStatus(
      request: request,
    );
  }
}
