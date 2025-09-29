import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/data/data_source/home/remote_data_source/home_remote_data_source.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/entities/requests/accept_order/accept_order_request_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/home/home_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _homeRemoteDataSource;
  const HomeRepositoryImpl(this._homeRemoteDataSource);

  @override
  Future<Result<List<OrderEntity>>> fetchAllDriverPendingOrders() async {
    return await _homeRemoteDataSource.fetchAllDriverPendingOrders();
  }

  @override
  Future<Result<void>> acceptOrder({
    required AcceptOrderRequestEntity request,
  }) async {
    return await _homeRemoteDataSource.acceptOrder(request: request);
  }
}
