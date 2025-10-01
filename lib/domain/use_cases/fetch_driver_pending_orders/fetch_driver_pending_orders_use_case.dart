import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/home/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
final class FetchDriverPendingOrdersUseCase {
  final HomeRepository _homeRepository;
  const FetchDriverPendingOrdersUseCase(this._homeRepository);
  Future<Result<List<OrderEntity>>> invoke() async {
    return await _homeRepository.fetchAllDriverPendingOrders();
  }
}
