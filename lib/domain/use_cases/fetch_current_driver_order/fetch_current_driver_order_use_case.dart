import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/order_details/order_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchCurrentDriverOrderUseCase {
  final OrderDetailsRepository _orderDetailsRepository;
  const FetchCurrentDriverOrderUseCase(this._orderDetailsRepository);
  Stream<Result<OrderEntity>> invoke({required String orderId}) async* {
    yield* _orderDetailsRepository.fetchCurrentDriverOrder(orderId: orderId);
  }
}
