import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/repositories/order_details/order_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchAllDriverOrdersUseCase {
  final OrderDetailsRepository _orderDetailsRepository;
  const FetchAllDriverOrdersUseCase(this._orderDetailsRepository);
  Future<Result<String?>> invoke() async {
    return await _orderDetailsRepository.fetchAllDriverOrders();
  }
}
