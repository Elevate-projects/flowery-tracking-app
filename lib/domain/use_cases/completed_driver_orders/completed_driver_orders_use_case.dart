import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/orders/orders_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CompletedDriverOrdersUseCase {
  final OrdersRepository _ordersRepository;
  const CompletedDriverOrdersUseCase(this._ordersRepository);
  Future<Result<List<OrderEntity>>> invoke() async {
    return await _ordersRepository.fetchDriverOrders();
  }
}
