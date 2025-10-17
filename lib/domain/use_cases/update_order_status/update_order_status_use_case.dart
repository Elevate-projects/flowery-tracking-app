import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/requests/order_details/update_order_status_request_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/order_details/order_details_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateOrderStatusUseCase {
  final OrderDetailsRepository _orderDetailsRepository;
  const UpdateOrderStatusUseCase(this._orderDetailsRepository);
  Future<Result<void>> invoke({
    required UpdateOrderStatusRequestEntity request,
  }) async {
    return await _orderDetailsRepository.updateCurrentDriverOrderStatus(
      request: request,
    );
  }
}
