import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/orders/remote_data_source/orders_remote_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/orders/orders_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrdersRepository)
class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDataSource _ordersRemoteDataSource;
  const OrdersRepositoryImpl(this._ordersRemoteDataSource);

  @override
  Future<Result<List<OrderEntity>>> fetchDriverOrders() async {
    return await _ordersRemoteDataSource.fetchDriverOrders();
  }
}
