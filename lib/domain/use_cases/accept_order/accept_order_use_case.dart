import 'package:flowery_tracking_app/api/client/api_result.dart';
import 'package:flowery_tracking_app/domain/entities/requests/accept_order/accept_order_request_entity.dart';
import 'package:flowery_tracking_app/domain/repositories/home/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AcceptOrderUseCase {
  final HomeRepository _homeRepository;
  const AcceptOrderUseCase(this._homeRepository);
  Future<Result<void>> invoke({
    required AcceptOrderRequestEntity request,
  }) async {
    return await _homeRepository.acceptOrder(request: request);
  }
}
